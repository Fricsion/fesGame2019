//
//  TitleScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import Cocoa
import GameplayKit
import SpriteKit
import AVFoundation

class TitleScene: SKScene {
    
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        // 3秒ごとに泡を生成します
        self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {_ in self.generateBubble()})
        self.backgroundColor = SKColor.black
        
        let bgm = SKAudioNode(fileNamed: "01Jelly.wav")
        bgm.autoplayLooped = true
        let volumeUp = SKAction.changeVolume(to: 2.0, duration: 0)
        bgm.run(volumeUp)
        self.addChild(bgm)
        
        generateTitlelogo()
        showControlHelp(position: CGPoint(x: self.view!.bounds.maxX/2, y: self.view!.bounds.maxY/2 - 200), descriptionText: "Press L & R to Play!")

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
    
    func showControlHelp(position: CGPoint, descriptionText: String) {
        var textures: [SKTexture] = []
        let altas = SKTextureAtlas(named: "Controller")
        for i in 1...6 {textures.append(altas.textureNamed("controller"+String(i)))}
        
        let controller = SKSpriteNode(texture: textures.first)
        let description = SKLabelNode()
        controller.position = position
        controller.alpha = 0.8
        description.position = CGPoint(x: position.x, y: position.y - 70.0)
        description.text = descriptionText
        description.fontName = "chalkduster"
        description.fontSize = 15
        description.fontColor = NSColor.gray
        
        controller.run(SKAction.repeatForever(SKAction.animate(with: [textures[0], textures[1]], timePerFrame: 0.5)))
        
        self.addChild(controller)
        self.addChild(description)
        
    }
    
    func generateBubble() {
        // 改善しなければならない、コンスタントにランダムな位置に泡を生成したいのだが…… ->解決: タイマーで一定の間隔で呼び出すよ
        let bubblingSoundOrigin = SKAction.playSoundFileNamed("teardrop.mp3", waitForCompletion: false)
        let changeVolume = SKAction.changeVolume(to: 0.01, duration: 0.0)
        let bubblingSound = SKAction.group([bubblingSoundOrigin, changeVolume])
        
        var bubbleTextures: [SKTexture] = []
        let bubbleAtlas = SKTextureAtlas(named: "bubble")
        for i in 1...7 {
            bubbleTextures.append(bubbleAtlas.textureNamed("bubble" + String(i)))
        }
        
        var amountOfBubbles = 0
        // とりあえずランダムな位置に泡を２０個生成
        while (amountOfBubbles < 20) {
            let (x, y) = (Int.random(in: 0..<Int((self.view!.bounds.maxX))), Int.random(in: -100..<0))
            let timeBubbling = Int.random(in: 8..<13)
            let scaleDegree = Float.random(in: 0.8..<1.2)
            
            let speedCoefficient = 1 / scaleDegree
            let driftingDuration = Float.random(in: 0.8..<2.0)
            let bubble = SKSpriteNode(texture: bubbleTextures.first)
            bubble.position = CGPoint(x: x, y: y)
            bubble.setScale(CGFloat(scaleDegree))
            
            bubble.physicsBody = SKPhysicsBody(circleOfRadius: 8)
            bubble.physicsBody?.affectedByGravity = false
            bubble.physicsBody?.velocity = CGVector(dx: 0, dy: Int(100 * speedCoefficient))
            let bubbling = SKAction.animate(with: [bubbleTextures[0], bubbleTextures[1], bubbleTextures[2]], timePerFrame: 0.2)
            let drift = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: Double(driftingDuration))
            let drifting = SKAction.repeatForever(SKAction.sequence([drift, drift.reversed()]))
            let disappearing = SKAction.animate(with: bubbleTextures, timePerFrame: 0.2)
            if scaleDegree > 1.1 {
                let action = SKAction.sequence([SKAction.repeat(bubbling, count: timeBubbling), bubblingSound, disappearing])
                bubble.run(drifting)
                bubble.run(action, completion: {bubble.removeFromParent()})
            } else {
                let action = SKAction.sequence([SKAction.repeat(bubbling, count: timeBubbling), disappearing])
                bubble.run(drifting)
                bubble.run(action, completion: {bubble.removeFromParent()})
            }
//            let actionGroup = SKAction.group([drifting, action])
             // アクションを実行して、すべて終了したらremoveFromParent実行
            // 破裂のアクションが終わったら消したいのだが……
            self.addChild(bubble)
            amountOfBubbles += 1
        }
    }
    
    override func keyUp(with event: NSEvent) {
        // スペースキーを押すことでゲームが開始される
        if event.keyCode == 49 {
            self.timer.invalidate() // 泡の生成はここで止まる
            removeAllChildren()
            
            let scene = FirstPhaseScene(size: self.scene!.size)
//            let scene = SecondPhaseScene(size: self.scene!.size)
            let transanime = SKTransition.moveIn(with: .down, duration: 2)
//            let scene = TravelScene(size: self.scene!.size)
//            let scene = GameoverScene(size: self.scene!.size)
            scene.scaleMode = .aspectFill
            self.view!.presentScene(scene, transition: transanime)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //nothing for now  
    }
}
