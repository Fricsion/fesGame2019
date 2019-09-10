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
    var moveDistanceX = 0
    var moveDistanceY = 0
    var sneakToggle: Bool! = false
    
    override func didMove(to view: SKView) {
        
        let bgm = SKAudioNode(fileNamed: "secondPhase.wav")
        self.addChild(bgm)
        
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2 - 100)
        self.addChild(player)
        
        let enemy = Jellypour(def_pos: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 + 100))
        self.addChild(enemy)
        
        player.physicsBody?.contactTestBitMask = enemy.physicsBody!.categoryBitMask
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in enemy.tearRain(in: self)})
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
