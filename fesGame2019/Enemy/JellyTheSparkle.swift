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
    
    var health: Int = 100
    var invincibility: Bool! = false
    var defeatFlag: Bool! = false
    
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
        
        self.alpha = 0.0
        
        let appear = SKAction.fadeIn(withDuration: 1)
        self.run(appear)
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(animation)
    }
    
    func getDamaged(in scene: SKScene) {
        let action = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
        self.run(SKAction.sequence([action, action.reversed()]))
        
        if !invincibility {
            self.health -= 1
        }
        if self.health <= 0 {
            if !self.defeatFlag {
                self.defeatFlag = true
                let newscene = TitleScene(size: self.scene!.size)
                newscene.scaleMode = SKSceneScaleMode.aspectFill
                scene.view!.presentScene(newscene)
            }
            
        }
    }
    
    func radialBullet(in scene: SKScene, def_pos: CGPoint, speed: Int, frequency: Float) {   // 放射状に泡を射出
        let max: Float = 1000.0
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
