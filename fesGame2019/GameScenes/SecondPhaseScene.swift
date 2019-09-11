//
//  File.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/08.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

let straightbulletBit: UInt32 = 1 << 4

class SecondPhaseScene: SKScene {
    
    let player = Player(def_pos: CGPoint(x: 0.0, y: 0.0))

    var moveDistanceX: Float = 0.0
    var moveDistanceY: Float = 0.0
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = NSColor.black
        
        for i in 0...5 {ZigZagNode(x: 0, y: 0 + 100 * i)}
        
        let bgm = SKAudioNode(fileNamed: "secondPhase.wav")
        self.addChild(bgm)
        
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2 - 100)
        self.addChild(player)
        
        let enemy = Jellypour(def_pos: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 + 100), player: self.player)
        
        self.run(SKAction.wait(forDuration: 3.0), completion: {
            self.addChild(enemy)
            self.player.physicsBody?.contactTestBitMask = enemy.physicsBody!.categoryBitMask
        })
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in enemy.tearRain(in: self)})
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

extension SecondPhaseScene: SKPhysicsContactDelegate {
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
            let enemy = node1 as! Jellypour
            let bullet = node2
            if node2.physicsBody?.categoryBitMask == bulletBit {
                enemy.getDamaged(in: self)
                bullet.removeFromParent()
            }
        }
        
        if node1.physicsBody?.categoryBitMask == playerBit {
            let player = node1 as! Player
            let straightbullet = node2
            if node2.physicsBody?.categoryBitMask == straightbulletBit {
                player.getDamaged(in: self)
                straightbullet.removeFromParent()
            }
        }
    }
}
