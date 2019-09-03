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
    
    var health = 1
    
    init(def_pos: CGPoint) {
        var textures: [SKTexture] = []
        let atlas = SKTextureAtlas(named: "jelly")
        for i in 1...3 {
            textures.append(atlas.textureNamed("jelly" + String(i)))
        }
        
        super.init(texture: textures[2], color: NSColor.clear, size: CGSize(width: 40, height: 40))
        self.position = def_pos
        
        let animation = SKAction.animate(withNormalTextures: textures, timePerFrame: 1.0)
        self.run(SKAction.repeatForever(animation))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0x1 << 1111
        self.physicsBody?.collisionBitMask = 0x1 << 1111
        
//        setLifeIndicator(health: 1)
        
    }
    
    func move(x: Int, y: Int) {
        self.position.x += CGFloat(x)
        self.position.y += CGFloat(y)
    }
    
//    let lifeIndicator: SKShapeNode
//
//    func setLifeIndicator(health: Int) {
//        let path = NSBezierPath.init()
//        path.appendArc(withCenter: NSPoint(x: 0, y: 0), radius: 30, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
//        let lifeIndicator = SKShapeNode(path: path.cgPath)
//        lifeIndicator.position = self.position
//    }
//
//    func updateLifeIndicator(health: Int) {
//        lifeIndicator.position = self.position
//    }
    func update() {
//        updateLifeIndicator(health: self.health)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
//
//extension NSBezierPath {
//
//    var cgPath: CGPath {
//        let path = CGMutablePath()
//        var points = [CGPoint](repeating: .zero, count: 3)
//        for i in 0 ..< self.elementCount {
//            let type = self.element(at: i, associatedPoints: &points)
//
//            switch type {
//            case .moveTo:
//                path.move(to: points[0])
//
//            case .lineTo:
//                path.addLine(to: points[0])
//
//            case .curveTo:
//                path.addCurve(to: points[2], control1: points[0], control2: points[1])
//
//            case .closePath:
//                path.closeSubpath()
//
//            @unknown default:
//                break
//            }
//        }
//        return path
//    }
//}
