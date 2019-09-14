//
//  GameOverScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/05.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class GameoverScene: SKScene {
    
    var progressFlag: Bool!
    
    override func didMove(to view: SKView) {
        
        self.progressFlag = false
        
        self.backgroundColor = NSColor.black
        
        self.run(SKAction.wait(forDuration: 0.2), completion: {
            let bgm = SKAudioNode(fileNamed: "05GameOver.wav")
            bgm.autoplayLooped = true
            self.addChild(bgm)
        })
        
        
        // ゲームオーバーの文字
        let gameover_str = SKLabelNode()
        gameover_str.text = "Game Over"
        gameover_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2)
        gameover_str.fontSize = 40
        gameover_str.fontName = "Chalkduster"
        self.addChild(gameover_str)
        
        // スコア表示
        scores.append(score)
        let your_score = SKLabelNode()
        your_score.text = "Your Final Score is \(score)"
        your_score.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2)
        your_score.fontSize = 20
        your_score.fontName = "Chalkduster"
        self.addChild(your_score)
        your_score.alpha = 0.0
        
        let highScore: Int = scores.max()!
        let high_score = SKLabelNode()
        high_score.text = "The highest score ever: \(highScore)"
        high_score.position = CGPoint(x: self.view!.bounds.maxX / 2, y: 40)
        high_score.fontSize = 20
        high_score.fontName = "chalkduster"
        self.addChild(high_score)
        high_score.alpha = 0.0
        
        let wait = SKAction.wait(forDuration: 2.0)
        let down = SKAction.move(by: CGVector(dx: 0, dy: -50), duration: 0.2)
        let rotate = SKAction.rotate(byAngle: -1/12 * CGFloat(Double.pi), duration: 0.4)
        let outDuration = Double.random(in: 0.2..<2.3)
        let inDuration = Double.random(in: 0.2..<2.3)
        let fadeoutAnime = SKAction.fadeAlpha(to: 0.4, duration: outDuration)
        let fadeinAnime = SKAction.fadeAlpha(to: 0.8, duration: inDuration)
        let actions = SKAction.sequence([wait, SKAction.group([rotate, down]), SKAction.repeatForever(SKAction.group([fadeoutAnime, fadeinAnime]))])
        gameover_str.run(actions)
        your_score.run(SKAction.sequence([wait, SKAction.fadeAlpha(to: 1.0, duration: 1.0)]))
        high_score.run(SKAction.sequence([wait, SKAction.fadeAlpha(to: 1.0, duration: 1.3)]))
        
        
        
        self.run(SKAction.wait(forDuration: 3.0), completion: {
            self.progressFlag = true
        })
    }
    
    override func keyDown(with event: NSEvent) {
        
        score = 0   // ゲームオーバー画面でスコア管理を終了して初期値に戻す
        // スコアの集計をとってハイスコアを表示したいのだが……
        if progressFlag {
            switch event.keyCode {
            case 49:
                let newscene = TitleScene(size: self.scene!.size)
                let transanime = SKTransition.flipHorizontal(withDuration: 2)
                newscene.scaleMode = SKSceneScaleMode.aspectFill
                self.view!.presentScene(newscene, transition: transanime)
            case 1:
                let scene = FirstPhaseScene(size: self.scene!.size)
                let transanime = SKTransition.moveIn(with: .down, duration: 2)
                scene.scaleMode = SKSceneScaleMode.aspectFill
                self.view!.presentScene(scene, transition: transanime)
                
            default:
                break
            }
        }
    }

}
