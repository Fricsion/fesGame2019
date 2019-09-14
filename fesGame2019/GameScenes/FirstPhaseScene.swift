//
//  GameScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import SpriteKit
import GameplayKit




class FirstPhaseScene: SKScene {
    
    let player = Player(def_pos: CGPoint(x: 0.0, y: 0.0))
    var moveDistanceX: Float!
    var moveDistanceY: Float!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = NSColor.black
        
        self.run(SKAction.playSoundFileNamed("smoke.mp3", waitForCompletion: false))

        moveDistanceX = 0.0
        moveDistanceY = 0.0
        
        let bgm = SKAudioNode(fileNamed: "02Jellyborne.wav")
        self.addChild(bgm)
        
        for i in 0...5 {ZigZagNode(x: 0, y: 0 + 100 * i)}
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2 - 100)
        self.addChild(player)
        player.addHPBar(in: self)

        let enemy = Jellyborne(def_pos: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 + 100))
        self.run(SKAction.wait(forDuration: 3.0), completion: {
            self.addChild(enemy)
            self.player.physicsBody?.contactTestBitMask = enemy.physicsBody!.categoryBitMask
        })

        let mx = self.view!.bounds.maxX
        let my = self.view!.bounds.maxY
        let upBlock = SKShapeNode(rect: CGRect(x: 0, y: self.view!.bounds.maxY, width: self.view!.bounds.maxX, height: 5))
        let rightBlock = SKShapeNode(rect: CGRect(x: mx * 8/10, y: self.view!.bounds.maxY, width: 5, height: -self.view!.bounds.maxY))
        let downBlock = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.view!.bounds.maxX, height: 5))
        let leftBlock = SKShapeNode(rect: CGRect(x: mx * 2/10, y: self.view!.bounds.maxY, width: 5, height: -self.view!.bounds.maxY))
        upBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.view!.bounds.maxX, height: 5))
        rightBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: my))
        downBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mx, height: 5))
        leftBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: my))
        
        upBlock.physicsBody?.isDynamic = false
        rightBlock.physicsBody?.isDynamic = false
        downBlock.physicsBody?.isDynamic = false
        leftBlock.physicsBody?.isDynamic = false

        upBlock.physicsBody?.categoryBitMask = wallBit
        
        self.addChild(upBlock)
        self.addChild(rightBlock)
        self.addChild(downBlock)
        self.addChild(leftBlock)
        
//        let messageView = SKView(frame: NSRect(x: 8/10 * mx, y: 0, width: 2/10 * mx, height: my))
//        let messageScene = MessageWindow()
//        messageScene.size = messageView.frame.size
//        messageView.presentScene(messageScene)
//        self.view!.addSubview(messageView)
//        messageView.showsFPS = true
//        messageView.showsNodeCount = true
    }

    func ZigZagNode(x: Int, y: Int) {
        let scr_width = self.view!.bounds.maxX
        let scr_height = self.view!.bounds.maxY
        let zigWidth = 50
        let zigHeight = 20
        let zigStartX = x
        let zigStartY = y
        
        let zigPath = NSBezierPath()
        zigPath.move(to: CGPoint(x: zigStartX, y: zigStartY))
        
        var coefficient = -1
        var counter = 0
        
        while zigWidth * counter < Int(scr_width) {
            counter += 1
            let nextPoint = CGPoint(x: zigStartX + zigWidth * counter, y: zigStartY + zigHeight * coefficient)
            coefficient *= -1
            
            zigPath.line(to: nextPoint)
        }
        
        let zigZag = SKShapeNode()
        zigZag.path = zigPath.cgPath
        zigZag.lineWidth = 60
        zigZag.lineCap = .round
        zigZag.strokeColor = NSColor(red: 20.0/255, green: 45.0/255, blue: 100.0/255, alpha: 0.5)
        self.addChild(zigZag)
        
        let goUp = SKAction.move(to: CGPoint(x: 0, y: Int(scr_height) + 300), duration: 8.0)
        zigZag.run(goUp, completion: { zigZag.removeFromParent()})
    }

    override func keyDown (with event: NSEvent) {
        var accelerateRate: Float = 1.0
        let modifiers: NSEvent.ModifierFlags = event.modifierFlags
        if modifiers.contains(NSEvent.ModifierFlags.shift) {
            accelerateRate = SlowDownRate
        } else if modifiers.contains(NSEvent.ModifierFlags.control) {
            accelerateRate = SpeedUpRate
        }
        
        switch event.keyCode {
        case 13:
            moveDistanceY = 5.0 * accelerateRate
        case 0:
            moveDistanceX = -5.0 * accelerateRate
        case 1:
            moveDistanceY = -5.0 * accelerateRate
        case 2:
            moveDistanceX = 5.0 * accelerateRate
        case 49:
            player.shoot(in: self)
        default:
            break
        }
    }
    
    override func keyUp (with event: NSEvent) {
        var accelerateRate: Float = 1.0
        let modifiers: NSEvent.ModifierFlags = event.modifierFlags
        if modifiers.contains(NSEvent.ModifierFlags.shift) {
            accelerateRate = SlowDownRate
        } else if modifiers.contains(NSEvent.ModifierFlags.control) {
            accelerateRate = SpeedUpRate
        }
        if accelerateRate != 1.0 {
            moveDistanceX = moveDistanceX / accelerateRate
            moveDistanceY = moveDistanceY / accelerateRate
        }
        
        switch event.keyCode {
        case 13, 1:
            moveDistanceY = 0
        case 0, 2:
            moveDistanceX = 0
        default:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        self.player.move(x: moveDistanceX, y: moveDistanceY)
        self.player.update(in: self)
    }
}

extension FirstPhaseScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("------------衝突しました------------")
        let node1: SKNode
        let node2: SKNode
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            (node1, node2) = (contact.bodyA.node!, contact.bodyB.node!)
        } else {
            (node1, node2) = (contact.bodyB.node!, contact.bodyA.node!)
        }
        if node1.physicsBody?.categoryBitMask == enemyBit {
            let enemy = node1 as! Jellyborne
            let bullet = node2
            if node2.physicsBody?.categoryBitMask == bulletBit {
                enemy.getDamaged(in: self)
                bullet.removeFromParent()
            }
        }
    }
}
