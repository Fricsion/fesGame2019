//
//  HomingBullet.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/10.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

// ホーミング泡はクラゲめがけて何度か軌道修正しながら向かってくる（修正回数を引数として、その値によって精度の高さをつける）また、修正をやめるタイミングを引数に持つ

class HomingBullet: SKSpriteNode {
    
    init(def_pos: CGPoint, time: CGFloat, precision: Int, speed: CGFloat) {
        
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "StraightBullet")
        for i in 1..<2 {
            textures.append(atlas.textureNamed("straightbullet" + String(i)))
        }
        super.init(texture: textures.first, color: SKColor.clear, size: CGSize(width: 20, height: 20))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(animation)
        
//        Timer.scheduledTimer(withTimeInterval: time/CGFloat(precision), repeats: true, block: {self.aim(player: <#T##CGPoint#>, speed: speed)})
    }
    
    func aim(player: CGPoint, speed: Int) {
//        let leng = (player.x - self.position.x)^2 + (player.y - self.position.y)^2
//        let len = sqrt(leng)
//        let moveX = (player.x - self.position.x) * speed / len
//        let moveY = (player.y - self.position.y) * speed / len
//        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
