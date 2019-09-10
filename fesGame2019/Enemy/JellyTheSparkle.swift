//
//  JellyTheSparkle.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/07.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class JellyTheSparkle: SKSpriteNode {
    init(def_pos: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "JellyTheSparkle")
        for i in 1..<3 {
            textures.append(atlas.textureNamed("jellythesparkle" + String(i)))
        }
        
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = enemyBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = bulletBit
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(animation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
