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
    
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
        print(scene)
    }
    
    init(def_pos: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "jelly")
        for i in 1...3 {
            textures.append(atlas.textureNamed("jelly" + String(i)))
        }
        
        super.init(texture: textures[0], color: NSColor.clear, size: CGSize(width: 40, height: 40))
        self.position = def_pos
        
        let animation = SKAction.animate(withNormalTextures: textures, timePerFrame: 1.0)
        self.run(SKAction.repeatForever(animation))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0x1 << 1111
        self.physicsBody?.collisionBitMask = 0x1 << 1111
    }
    
    func move(x: Int, y: Int) {
        self.position.x += CGFloat(x)
        self.position.y += CGFloat(y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
