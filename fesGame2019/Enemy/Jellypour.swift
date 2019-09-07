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
    
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
        print(scene)
    }
    
    init(def_pos: CGPoint) {
        let texture = SKTexture(imageNamed: "jellypour")
        super.init(texture: texture, color: NSColor.clear, size: CGSize(width: 200, height: 200))
        self.position = def_pos
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
