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
    var invincibility: Bool!
    var defeatFlag: Bool!
    
    let hpBar: LifeIndicator = LifeIndicator()
    
    init(def_pos: CGPoint) {
        
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "jelly")
        for i in 1...3 {
            textures.append(atlas.textureNamed("jelly" + String(i)))
        }
        
        super.init(texture: textures[2], color: NSColor.clear, size: CGSize(width: 40, height: 40))
        
        self.name = "player"
        
        self.position = def_pos
        
        self.health = 100
        self.invincibility = false
        self.defeatFlag = false
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        self.run(SKAction.repeatForever(animation), withKey: "Normal")
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = playerBit
        self.physicsBody?.collisionBitMask = wallBit
        self.physicsBody?.contactTestBitMask = 0
        
    }
    
    func addHPBar(in scene: SKScene) {
        scene.addChild(self.hpBar)
    }
    
    func move(x: Float, y: Float) {
        if !defeatFlag {
            self.position.x += CGFloat(x)
            self.position.y += CGFloat(y)
        }
    }
    
    func shoot(in scene: SKScene) {
        if !defeatFlag {
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
    }

    
    func getDamaged(in scene: SKScene) {
        if !self.invincibility {
            if self.health <= 0 {
                if !self.defeatFlag {
                    self.defeatFlag = true
                    self.hpBar.updateHealth(health: self.health)
                    let se = SKAction.playSoundFileNamed("jellyDie.wav", waitForCompletion: false)
                // 通常時のアニメーションを止める（消す）
                self.removeAction(forKey: "Normal")
                
                // 死ぬときの砕けるアニメーション
                
                var dyingPlayer: [SKTexture] = []
                let atlas = SKTextureAtlas(named: "jelly")
                for i in 4...8 {
                    dyingPlayer.append(atlas.textureNamed("jelly"+String(i)))
                }
                let dyingAnimation = SKAction.animate(with: dyingPlayer, timePerFrame: 0.2)
                // アニメーションが全て終わったらゲームオーバー画面へ
                self.run(SKAction.group([dyingAnimation, se]), completion: {
                    let newscene = GameoverScene(size: self.scene!.size)
                    newscene.scaleMode = SKSceneScaleMode.aspectFill
                    let reveal = SKTransition.fade(withDuration: 1)
                    scene.view!.presentScene(newscene, transition: reveal)})
                }
                
            } else {
                self.invincibility = true
                self.health -= 10
                self.hpBar.updateHealth(health: self.health)
                print(self.health as Any)
                
                let se = SKAction.playSoundFileNamed("blink.mp3", waitForCompletion: false)
                
                let blink = SKAction.sequence([SKAction.hide(),
                                                  SKAction.wait(forDuration: 0.2),
                                                  SKAction.unhide(),
                                                  SKAction.wait(forDuration: 0.2)])
                let blinking = SKAction.repeat(blink, count: 3)
                
                let shake = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
                let shaking = SKAction.sequence([shake, shake.reversed()])
                
                let group = SKAction.group([shaking, blinking, se])
                self.run(group, completion: {
                    self.invincibility = false
                })
            }
        }
    }
    
    func update(in scene: SKScene) {
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
