//
//  File.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/06.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class TravelScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = NSColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        let loading_str = SKLabelNode()
        loading_str.text = "Now Traveling to Deep in the Sea."
        loading_str.fontSize = 20
        loading_str.fontName = "ChalkDuster"
        loading_str.fontColor = NSColor(red: 95.0/255, green: 215.0/255, blue: 243.0/255, alpha: 1.0)
        loading_str.position = CGPoint(x: 300, y: 20)
        
        let sink = SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 2.0)
        let float = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.2)
        let hovering = SKAction.sequence([float, sink])
        loading_str.run(SKAction.repeatForever(hovering))
        
        self.addChild(loading_str)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.ZigZagNode(x: 0, y: -100)})
    }
    
    func ZigZagNode(x: Int, y: Int) {
        let scr_width = self.view!.bounds.maxX
        let scr_height = self.view!.bounds.maxY
        let zigWidth = 50
        let zigHeight = 20
        let zigStartX = x
        let zigStartY = y
        
        let zigPath = NSBezierPath()
        zigPath.move(to: CGPoint(x: zigStartX, y: zigStartY))
        
        var coefficient = -1
        var counter = 0
        
        while zigWidth * counter < Int(scr_width) {
            counter += 1
            let nextPoint = CGPoint(x: zigStartX + zigWidth * counter, y: zigStartY + zigHeight * coefficient)
            coefficient *= -1
            
            zigPath.line(to: nextPoint)
        }
        
        let zigZag = SKShapeNode()
        zigZag.path = zigPath.cgPath
        zigZag.lineWidth = 60
        zigZag.lineCap = .round
        zigZag.strokeColor = NSColor(red: 20.0/255, green: 45.0/255, blue: 100.0/255, alpha: 0.5)
        self.addChild(zigZag)
        
        let goUp = SKAction.move(to: CGPoint(x: 0, y: Int(scr_height) + 300), duration: 8.0)
        zigZag.run(goUp, completion: { zigZag.removeFromParent()})
    }

    
    func generateBubble() {
        // 改善しなければならない、コンスタントにランダムな位置に泡を生成したいのだが…… ->解決: タイマーで一定の間隔で呼び出すよ
        var bubbleTextures: [SKTexture] = []
        let bubbleAtlas = SKTextureAtlas(named: "bubble")
        for i in 1...7 {
            bubbleTextures.append(bubbleAtlas.textureNamed("bubble" + String(i)))
        }
        
        var amountOfBubbles = 0
        // とりあえずランダムな位置に泡を２０個生成
        while (amountOfBubbles < 100) {
            let (x, y) = (Int.random(in: 0..<Int((self.view!.bounds.maxX))), Int.random(in: -100..<0))
            let timeBubbling = Int.random(in: 8..<13)
            let scaleDegree = Float.random(in: 0.8..<1.2)
            let speedCoefficient = 1 / scaleDegree
            let bubble = SKSpriteNode(texture: bubbleTextures.first)
            bubble.position = CGPoint(x: x, y: y)
            bubble.setScale(CGFloat(scaleDegree))
            
            bubble.physicsBody = SKPhysicsBody(circleOfRadius: 8)
            bubble.physicsBody?.affectedByGravity = false
            bubble.physicsBody?.velocity = CGVector(dx: 0, dy: Int(100 * speedCoefficient))
            let bubbling = SKAction.animate(with: [bubbleTextures[0], bubbleTextures[1], bubbleTextures[2]], timePerFrame: 0.2)
            let disappearing = SKAction.animate(with: bubbleTextures, timePerFrame: 0.2)
            let action = SKAction.sequence([SKAction.repeat(bubbling, count: timeBubbling), disappearing])
            bubble.run(action, completion: {bubble.removeFromParent()})
            // 破裂のアクションが終わったら消したいのだが……
            self.addChild(bubble)
            amountOfBubbles += 1
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
