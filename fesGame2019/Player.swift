//
//  Player.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {

    
    var health: Int!
    
    init(def_pos: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "jelly")
        for i in 1...3 {
            textures.append(atlas.textureNamed("jelly" + String(i)))
        }
        
        super.init(texture: textures[2], color: NSColor.clear, size: CGSize(width: 40, height: 40))
        self.position = def_pos
        
        self.health = 100
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = playerBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 0
        
    }
    
    func move(x: Int, y: Int) {
        self.position.x += CGFloat(x)
        self.position.y += CGFloat(y)
    }
    
    func shoot(in scene: SKScene) {
        
        let bullet = SKShapeNode(circleOfRadius: 3)
        bullet.fillColor = NSColor.yellow
        bullet.position = self.position
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = bulletBit
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.contactTestBitMask = enemyBit
        bullet.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
        scene.addChild(bullet)
    }
    
    func die(scene: SKScene) {
        // 通常時のアニメーションを止める（消す）
        self.removeAllActions()
        
        // 死ぬときの砕けるアニメーション
        var dyingPlayer: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "jelly")
        for i in 4..<8 {
            dyingPlayer.append(atlas.textureNamed("jelly"+String(i)))
        }
        let dyingAnimation = SKAction.animate(with: dyingPlayer, timePerFrame: 0.4)
        self.run(dyingAnimation)
        
        self.removeFromParent()
        
        // ゲームオーバー画面へ
        let scene = GameoverScene(size: scene.scene!.size)
        scene.scaleMode = SKSceneScaleMode.aspectFill
        scene.view!.presentScene(scene)
    }
    
    func getDamaged() {
        
    }
    
    
    func update(in scene: SKScene) {
        if self.health <= 0 {
            die(scene: scene)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
