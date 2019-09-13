//
//  HomingBullet.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/10.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

// ホーミング泡はクラゲめがけて何度か軌道修正しながら向かってくる（修正回数を引数として、その値によって精度の高さをつける）また、修正をやめるタイミングを引数に持つ

class HomingBullet: SKSpriteNode {
    
    var (moveX, moveY): (CGFloat, CGFloat) = (0.0, 0.0)
    
    init(in scene: SKScene, def_pos: CGPoint) {
        
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "HomingBullet")
        for i in 1...7 {
            textures.append(atlas.textureNamed("homingbullet" + String(i)))
        }
        super.init(texture: textures.first, color: SKColor.clear, size: CGSize(width: 20, height: 20))
        self.position = def_pos
        
        let speed: Float = 30.0  // 1秒あたり、100ピクセル
        let time: Float = 10.0 // 追尾を行う時間
        let timeErase: Float = 10.0 // 消滅する時間
        let precision: Float = 100.0 // 消滅するまでに軌道修正（aim）する回数
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = straightbulletBit
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = playerBit
        
        let animation = SKAction.animate(with: Array(textures[0...3]), timePerFrame: 0.2)
        self.run(animation)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in self.update()})
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time/precision), repeats: true, block: {_ in self.aim(in: scene, speed: speed)})
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(timeErase), repeats: false, block: {_ in
            timer.invalidate()
            self.run(SKAction.animate(with: Array(textures[4...6]), timePerFrame: 0.2), completion: { 
                self.removeFromParent()
            })
            
            })
    }
    
    func aim(in scene: SKScene, speed: Float) {
        let player: Player = scene.childNode(withName: "player") as! Player
        let (px, py) = (player.position.x, player.position.y)
        let (bx, by) = (self.position.x, self.position.y)
        let (rawVX, rawVY) = (px - bx, py - by)
        let adjestedVector = adjestVector(givenVector: CGVector(dx: rawVX, dy: rawVY), magnitude: 5)

        self.moveX = adjestedVector.dx
        self.moveY = adjestedVector.dy
    }
    
    func update() {
        self.position.x += self.moveX
        self.position.y += self.moveY
        print(self.moveX, self.moveY)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension HomingBullet {
    func adjestVector(givenVector: CGVector, magnitude: CGFloat) -> CGVector {
        let (dx, dy) = (givenVector.dx, givenVector.dy)
        let (a, b) = (pow(dx, 2), pow(dy, 2))
        var n = sqrt(a + b)
        
        if n == 0 {
            n = 0.01
        }
        
        let adjestedVector: CGVector = CGVector(dx: dx * magnitude / n, dy: dy * magnitude / n)
        return adjestedVector
    }
}
