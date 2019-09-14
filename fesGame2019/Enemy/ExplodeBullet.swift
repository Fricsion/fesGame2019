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
    
    init(def_pos: CGPoint, timing: TimeInterval, destination: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "ExplodeBullet")
        for i in 1...5 {
            textures.append(atlas.textureNamed("explodebullet" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 20, height: 20))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        let (rawVX, rawVY) = (destination.x - self.position.x, destination.y - self.position.y)
        let adjestedV = adjestVector(givenVector: CGVector(dx: rawVX, dy: rawVY), magnitude: 100)
        let (vecX, vecY) = (adjestedV.dx, adjestedV.dy)
        
        self.run(SKAction.repeatForever(SKAction.animate(with: Array(textures[0...2]), timePerFrame: 0.1)))
        
        self.run(SKAction.move(by: CGVector(dx: vecX, dy: vecY), duration: timing))
        
        Timer.scheduledTimer(withTimeInterval: timing, repeats: false, block: {_ in self.explode(textures: textures)})
    }
    
    func explode(textures: [SKTexture]) {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 20)
        let blink = SKAction.sequence([SKAction.fadeAlpha(to: 0.2, duration: 0.2),
                                       SKAction.fadeAlpha(to: 0.8, duration: 0.2)])
        let blinking = SKAction.repeat(blink, count: 2)
        let explosion = SKAction.scale(by: 2.0, duration: 0.1)
        let explosionAnime = SKAction.animate(with: Array(textures[3...4]), timePerFrame: 0.2)
        let explode = SKAction.group([explosion, explosionAnime])
        let wait = SKAction.wait(forDuration: 0.5)
        
        self.run(SKAction.sequence([blinking, explode, wait]), completion: {
            self.removeFromParent()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension ExplodeBullet {
    func adjestVector(givenVector: CGVector, magnitude: CGFloat) -> CGVector {
        let (dx, dy) = (givenVector.dx, givenVector.dy)
        let (a, b) = (pow(dx, 2), pow(dy, 2))
        let n = sqrt(a + b)
        
        let adjestedVector: CGVector = CGVector(dx: dx * magnitude / n, dy: dy * magnitude / n)
        return adjestedVector
    }
}
