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
    
    var health: Int!
    
    init(def_pos: CGPoint) {
        
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "FirstPhase")
        for i in 1..<3 {
            textures.append(atlas.textureNamed("tansan1-" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
//        self.zRotation = CGFloat(45.0 / 180 * Double.pi)
        self.health = 100
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.categoryBitMask = 0b0000
        self.physicsBody?.collisionBitMask = 0b0000
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
        
        // 仮置き、まだ当たり判定できてないからダメージ受けようがないしね
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.getDamaged()})
        
    }
    
    func getDamaged() {
        self.texture = SKTexture(imageNamed: "FirstPhase/tansan1-3")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}
