//
//  Jellypour.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/07.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class Jellypour: SKSpriteNode {
    
    var health: Int!
    var invincibility: Bool!
    
    init(def_pos: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "Jellypour")
        for i in 1...3 {
            textures.append(atlas.textureNamed("jellypour" + String(i)))
        }
        
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
        
        self.health = 100
        self.invincibility = false
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = enemyBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = bulletBit
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(SKAction.sequence([animation, animation.reversed()])))
    }

    func fire(in scene: SKScene) {
        let bullet = ExplodeBullet(def_pos: self.position, timing: 1.0)
        scene.addChild(bullet)
    }
    
    func tearRain(in scene: SKScene) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "Jellypour")
        for i in 4...5 {
            textures.append(atlas.textureNamed("jellypour" + String(i)))
        }
        
        self.run(SKAction.animate(with: textures, timePerFrame: 0.3))
        
        var tearCount = 0
        while tearCount <= 100 {
//            let (x, y) = (Int.random(in: 0..<Int(scene.view!.bounds.maxX)), Int.random(in: Int(scene.view!.bounds.maxY)..<Int(scene.view!.bounds.maxY) + 200))
            let (x, y) = (Int.random(in: 0..<800), Int.random(in: 600..<800))
            let tear = StraightBullet(def_pos: CGPoint(x: x, y: y))
            scene.addChild(tear)
            tearCount += 1
        }
        
    }
    
    func getDamaged(in scene: SKScene) {
        let action = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
        self.run(SKAction.sequence([action, action.reversed()]))
        fire(in: scene)
        
        if self.health <= 0 {
            let newscene = ThirdPhaseScene(size: self.scene!.size)
            newscene.scaleMode = SKSceneScaleMode.aspectFill
            scene.view!.presentScene(newscene)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
