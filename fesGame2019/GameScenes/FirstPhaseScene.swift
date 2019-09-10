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
    var moveDistanceX = 0
    var moveDistanceY = 0
    var sneakToggle: Bool! = false
    
    override func didMove(to view: SKView) {

        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2 - 100)
        self.addChild(player)

        let enemy = Jellyborne(def_pos: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 + 100))
        self.addChild(enemy)
        
        player.physicsBody?.contactTestBitMask = enemy.physicsBody!.categoryBitMask
    }


    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            moveDistanceY = 5
        case 0:
            moveDistanceX = -5
        case 1:
            moveDistanceY = -5
        case 2:
            moveDistanceX = 5
        case 49:
            player.shoot(in: self)
        case 56:
            sneakToggle = true
        default:
            break
        }
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13, 1:
            moveDistanceY = 0
        case 0, 2:
            moveDistanceX = 0
        case 56:
            sneakToggle = false
        default:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if sneakToggle {
            self.player.move(x: moveDistanceX/2, y: moveDistanceY/2)
        } else {
            self.player.move(x: moveDistanceX, y: moveDistanceY)
        }
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
