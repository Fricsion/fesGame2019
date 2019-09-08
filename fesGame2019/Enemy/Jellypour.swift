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
        for i in 1..<3 {
            textures.append(atlas.textureNamed("jellypour" + String(i)))
        }
        
        super.init(texture: textures.first, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
        
        self.health = 100
        self.invincibility = false
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        
    }
    
    func getDamaged() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
