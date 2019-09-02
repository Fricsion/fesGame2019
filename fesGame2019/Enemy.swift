//
//  Enemy.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
        print(scene)
    }
    
    init(def_pos: CGPoint) {
        let enemy_img = "enemy"
        super.init(texture: SKTexture(imageNamed: enemy_img), color: NSColor.clear, size: CGSize(width: 30, height: 30))
        self.position = def_pos
        self.zRotation = CGFloat(45.0 / 180 * Double.pi)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        self.physicsBody?.categoryBitMask = 0x1 << 0001
        self.physicsBody?.collisionBitMask = 0x1 << 1111
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}
