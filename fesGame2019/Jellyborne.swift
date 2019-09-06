//
//  Enemy.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

//// ジェリーボーンは第一形態の設定名です。
//回転しかしないし、攻撃も行わないチュートリアルボス的な立場です。

class Jellyborne: SKSpriteNode, SKPhysicsContactDelegate {
    
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
        self.physicsBody?.categoryBitMask = 0b0001
        self.physicsBody?.collisionBitMask = 0b0001
        self.physicsBody?.contactTestBitMask = 0b0100
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
        
        // 仮置き、まだ当たり判定できてないからダメージ受けようがないしね
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.getDamaged()})
        
    }
    
    func getDamaged() {
        self.texture = SKTexture(imageNamed: "FirstPhase/tansan1-3")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision occured by enemy")
        getDamaged()
    }
    
    func prostrate() { // １８０度回転して、ダメージを与えられるようになる
        let action = SKAction.rotate(toAngle: CGFloat(Double.pi), duration: 1.0)
        self.run(action)
    }
    
    func spin() { // 高速回転をその場でぐるぐる、特に効果はない
        let action = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: 0.5)
        self.run(SKAction.repeat(action, count: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}
