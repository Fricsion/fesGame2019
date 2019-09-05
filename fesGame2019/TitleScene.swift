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
    
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        // 3秒ごとに泡を生成します
        self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.generateBubble()})
        self.backgroundColor = SKColor.black
        
        generateTitlelogo()

    }
    
    func generateTitlelogo() {
        let gametitle_str = SKLabelNode()
        gametitle_str.text = "Jelly of War"
        gametitle_str.fontSize = 40
        gametitle_str.fontName = "Chalkduster"
        gametitle_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2)
        gametitle_str.zPosition = 30
        let fadeoutAnime = SKAction.fadeAlpha(to: 0.5, duration: 2.3)
        let fadeinAnime = SKAction.fadeAlpha(to: 1, duration: 2.3)
        let actions = SKAction.sequence([fadeoutAnime, fadeinAnime])
        gametitle_str.run(SKAction.repeatForever(actions))
        self.addChild(gametitle_str)
    }
    
    func generateBubble() {
        // 改善しなければならない、コンスタントにランダムな位置に泡を生成したいのだが…… ->解決
        var bubbleTextures: [SKTexture] = []
        let bubbleAtlas = SKTextureAtlas(named: "bubble")
        for i in 1...3 {
            bubbleTextures.append(bubbleAtlas.textureNamed("bubble" + String(i)))
        }
        
        var amountOfBubbles = 0
        // とりあえずランダムな位置に泡を２０個生成
        while (amountOfBubbles < 20) {
            let (x, y) = (Int.random(in: 0..<Int((self.view!.bounds.maxX))), Int.random(in: -100..<0))
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
        // スペースキーを押すことでゲームが開始される
        if event.keyCode == 49 {
            self.timer.invalidate()
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(scene)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //nothing for now  
    }
}
