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
        self.backgroundColor = NSColor.black
        let loading_str = SKLabelNode()
        loading_str.text = "Now Traveling to Another Scene..."
        loading_str.position = CGPoint(x: 0, y: 20)
        
        self.addChild(loading_str)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {_ in self.generateBubble()})
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
