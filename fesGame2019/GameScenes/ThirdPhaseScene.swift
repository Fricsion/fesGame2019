//
//  ThirdPhaseScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/10.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class ThirdPhaseScene: SKScene {
    
    let player = Player(def_pos: CGPoint(x: 0.0, y: 0.0))
    var moveDistanceX: Float = 0
    var moveDistanceY: Float = 0
    
    override func didMove(to view: SKView) {
        
//        let bgm = SKAudioNode(fileNamed: "")
//        self.addChild(bgm)
        
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2 - 100)
        self.addChild(player)
        
        let enemy = JellyTheSparkle(def_pos: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 + 100))
        self.addChild(enemy)
        
        player.physicsBody?.contactTestBitMask = enemy.physicsBody!.categoryBitMask
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

extension ThirdPhaseScene: SKPhysicsContactDelegate {
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
            let enemy = node1 as! JellyTheSparkle
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
