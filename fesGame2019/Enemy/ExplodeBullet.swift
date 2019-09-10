//
//  ExplodeBullet.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/10.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

// ある一定のタイミングで爆発して範囲攻撃を与える泡

class ExplodeBullet: SKSpriteNode {
    
    init(def_pos: CGPoint, timing: TimeInterval) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "StraightBullet")
        for i in 1..<2 {
            textures.append(atlas.textureNamed("straightbullet" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.yellow, size: CGSize(width: 20, height: 20))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        Timer.scheduledTimer(withTimeInterval: timing, repeats: false, block: {_ in self.explode()})
    }
    
    func explode() {
        let explosion = SKAction.scale(by: 2.0, duration: 0.1)
        self.run(explosion, completion: {
            self.removeFromParent()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}