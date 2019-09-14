//
//  ScatterBullet.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/13.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class ScatterBullet: SKSpriteNode {
    
    init(def_pos: CGPoint, vector: CGVector, timing: TimeInterval, in scene: SKScene) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "bubble")
        for i in 1...7 {
            textures.append(atlas.textureNamed("bubble" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 40, height: 40))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.velocity = vector
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        let animation = SKAction.animate(with: Array(textures[0...2]), timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
        Timer.scheduledTimer(withTimeInterval: timing, repeats: false, block: {_ in 
            self.scatter(in: scene, frequency: 0.05, textures: textures)
        })
    }
    
    func scatter(in scene: SKScene, frequency: Float, textures: [SKTexture]) {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 10)
        
        let def_pos = self.position
        let speed = 100
        let max: Float = 1000.0
        let frequency: Float = 0.02
        let count: Int = Int(max * frequency)
        let angle = 2.0 * Double.pi / Double(count) // 2pi を count 分割する　→ 泡の射線通しの間の角度
        var i = 0
        while i <= count {
            let angleNow = angle * Double(i)
            let vectorX = cos(angleNow) * Double(speed)
            let vectorY = sin(angleNow) * Double(speed)
            let bullet = StraightBullet(def_pos: def_pos, vector: CGVector(dx: vectorX, dy: vectorY))
            scene.addChild(bullet)
            i += 1
        }
        self.run(SKAction.animate(with: Array(textures[3...6]), timePerFrame: 0.2), completion: {
            self.removeFromParent()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
