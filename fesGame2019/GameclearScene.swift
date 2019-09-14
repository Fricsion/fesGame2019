
//
//  Gameclear.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/14.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class GameclearScene: SKScene {
    
    var progressFlag: Bool!
    
    override func didMove(to view: SKView) {
        progressFlag = false
        
        self.backgroundColor = NSColor.black
        
        let (mx, my) = (self.view!.bounds.maxX, self.view!.bounds.maxY)
        let gameclear_str = SKLabelNode()
        gameclear_str.text = "Invader Vanished"
        gameclear_str.position = CGPoint(x: CGFloat(mx/2), y: CGFloat(my/2))
        gameclear_str.fontName = "chalkduster"
        gameclear_str.fontSize = 40
        self.addChild(gameclear_str)
        
        let fadeoutAnime = SKAction.fadeAlpha(to: 0.5, duration: 2.0)
        let fadeinAnime = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let fade = SKAction.sequence([fadeoutAnime, fadeinAnime])
        gameclear_str.run(SKAction.repeatForever(fade))
        
        let sink = SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 2.0)
        let float = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.2)
        let hovering = SKAction.sequence([float, sink])
        gameclear_str.run(SKAction.repeatForever(hovering))
        
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
            default:
                break
            }
        }
    }
}
