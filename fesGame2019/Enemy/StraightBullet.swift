//
//  StraightBullet.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/08.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

// 敵の撃ってくる泡はなぜか、水より比重が大きい、それゆえに下に降ってくるのだ
// 自然の摂理に反するそれは、何か、炭酸ゼリーたちの心を体現しているようにも見える

class StraightBullet: SKSpriteNode {
    init(def_pos: CGPoint, vector: CGVector) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "StraightBullet")
        for i in 1...2 {
            textures.append(atlas.textureNamed("straightbullet" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 20, height: 20))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = vector
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeat(animation, count: 30), completion: {
            self.removeFromParent()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
