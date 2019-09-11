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

class Jellyborne: SKSpriteNode {

    var health: Int!
    var durability: Int!
    var invincible: Bool!   // 攻撃を与えられる状態であるかどうか true -> 無敵
    
    var defeatFlag: Bool!   // 倒される時にtrueになることで、それ以後の処理を止めることができる
    
    init(def_pos: CGPoint) {
        
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "Jellyborne")
        for i in 1..<3 {
            textures.append(atlas.textureNamed("jellyborne" + String(i)))
        }
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
        self.zRotation = CGFloat(Double.pi)
        self.health = 20
        self.durability = 1
        self.invincible = true  // 初期状態ではダメージが入らない
        self.defeatFlag = false
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 20))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.categoryBitMask = enemyBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = bulletBit
        
        self.alpha = 0.0
        
        let appear = SKAction.fadeIn(withDuration: 1)
        self.run(appear)
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation))
        
    }
    
    func getDamaged(in scene: SKScene) {
        
        if !self.invincible {
            //          攻撃を受けた時に左右に振れるアクション
            let se = SKAction.playSoundFileNamed("switch.mp3", waitForCompletion: true)
            let action = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
            self.run(SKAction.group([(SKAction.sequence([action, action.reversed()])), se]))
            
            self.texture = SKTextureAtlas(named: "Jellyborne").textureNamed("jellyborne3")
            self.durability -= 1
            self.health -= 10
            print(self.health as Any)
            if self.durability <= 0 {
                prostrate()
                self.durability = 10
            }
        } else {
            let se = SKAction.playSoundFileNamed("boyon.mp3", waitForCompletion: false)
            self.run(se)
            self.durability -= 1
            if self.durability <= 0 {
                self.durability = 3
                prostrate()
            }
        }
        
        if self.health <= 0 {
            // Jellyborne撃破後のフロー
            if !self.defeatFlag {
                self.defeatFlag = true
                self.run(SKAction.playSoundFileNamed("don.mp3", waitForCompletion: true))
                let newscene = SecondPhaseScene(size: self.scene!.size)
                let transanime = SKTransition.moveIn(with: .down, duration: 2)
                newscene.scaleMode = SKSceneScaleMode.aspectFill
                scene.view!.presentScene(newscene, transition: transanime)
            }
        }
    }
    
    func prostrate() { // １８０度回転して、ダメージを与えられるようになる
        let action = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1.0)
        self.run(action, completion: {
            self.invincible = !self.invincible
        })
    }
    
    func spin() { // 高速回転をその場でぐるぐる、特に効果はない
        let action = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: 0.5)
        self.run(SKAction.repeat(action, count: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
