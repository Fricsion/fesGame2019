//
//  Player.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode, SKPhysicsContactDelegate {
    
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
        print(scene)
    }
    
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
        self.physicsBody?.categoryBitMask = 0b1000
        self.physicsBody?.collisionBitMask = 0b1000
        self.physicsBody?.contactTestBitMask = 0b0000
        
    }
    
    func move(x: Int, y: Int) {
        self.position.x += CGFloat(x)
        self.position.y += CGFloat(y)
    }
    
    func shoot() {
        let bullet = SKShapeNode(circleOfRadius: 3)
        bullet.fillColor = NSColor.yellow
        bullet.position = self.position
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = 0b0100
        bullet.physicsBody?.collisionBitMask = 0b0100
        bullet.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
        self.gameScene.addChild(bullet)
    }
    
    func die() {
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
        let scene = GameoverScene(size: self.gameScene.scene!.size)
        scene.scaleMode = SKSceneScaleMode.aspectFill
        self.gameScene.view!.presentScene(scene)
    }
    
    func getDamaged() {
        
    }
    
    
    func update() {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision occured by player")
        getDamaged()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
