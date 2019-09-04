//
//  TitleScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import GameplayKit

class TitleScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
//        let topColor = NSColor(red: 0.54, green: 0.74, blue: 0.74, alpha: 1)
//        let bottomColor = NSColor(red: 0.07, green: 0.13, blue: 0.26, alpha: 1)
//
//        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
//
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = gradientColors
//
//        gradientLayer.frame = self.view!.bounds
//
//        self.view!.layer!.insertSublayer(gradientLayer, at: 0)
//
        let gametitle_str = SKLabelNode()
        gametitle_str.text = "Jellies of War"
        gametitle_str.fontSize = 40
        gametitle_str.fontName = "Chalkduster"
        gametitle_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2)
        gametitle_str.zPosition = 30
        self.addChild(gametitle_str)
        
        generateBubble()
        
    }
    
    func generateBubble() {
        var bubbleTextures: [SKTexture] = []
        let bubbleAtlas = SKTextureAtlas(named: "bubble")
        for i in 1...3 {
            bubbleTextures.append(bubbleAtlas.textureNamed("bubble" + String(i)))
        }
        
        var amountOfBubbles = 0
        while (amountOfBubbles < 20) {
            let (x, y) = (Int.random(in: 0..<500), Int.random(in: -100..<0))
            let bubble = SKSpriteNode(texture: bubbleTextures.first)
            bubble.position = CGPoint(x: x, y: y)
            bubble.physicsBody = SKPhysicsBody(circleOfRadius: 8)
            bubble.physicsBody?.affectedByGravity = false
            bubble.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
            let bubbling = SKAction.animate(with: bubbleTextures, timePerFrame: 0.2)
            bubble.run(SKAction.repeatForever(bubbling))
            self.addChild(bubble)
            amountOfBubbles += 1
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 49 {
   
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(scene)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //nothing for now  
    }
}
