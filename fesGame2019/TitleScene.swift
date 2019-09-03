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
//        let gametitle_str = SKLabelNode()
//        gametitle_str.text = "Jellies of War"
//        gametitle_str.fontSize = 40
//        gametitle_str.fontName = "Chalkduster"
//        gametitle_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2)
//        gametitle_str.zPosition = 30
//        self.addChild(gametitle_str)
        
        let bubbleImg = SKTexture.init(imageNamed: "bubble_dot")
        var bubbleTexture: [SKTexture] = []
        let size = 128 / 4
        for i in 0..<3 {
            for j in 0..<3 {
                let y = size * i
                let x = size * j
            //指定したサイズをtextureとして切り取る
            let texture = SKTexture.init(rect: CGRect(x: x, y: y, width: size, height: size), in: bubbleImg)
            //配列に入れる
            bubbleTexture.append(texture)
            }
        }
        
        let bubble = SKSpriteNode.init(texture: bubbleTexture.first)
        bubble.position = CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2)
        let bubbling = SKAction.animate(withNormalTextures: bubbleTexture, timePerFrame: 0.3)
        bubble.run(SKAction.repeatForever(bubbling))


        
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 36 {
            print("hello")
   
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(scene)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //nothing for now  
    }
}
