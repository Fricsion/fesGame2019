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
    override func didMove(to view: SKView) {
        self.backgroundColor = NSColor.black
        
        let bgm = SKAudioNode(fileNamed: "Gameover.wav")
        bgm.autoplayLooped = true
        self.addChild(bgm)
        
        let gameover_str = SKLabelNode()
        gameover_str.text = "Game Over"
        gameover_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2)
        gameover_str.fontSize = 40
        gameover_str.fontName = "Chalkduster"
        
        self.addChild(gameover_str)
        
        let wait = SKAction.wait(forDuration: 2.0)
        let down = SKAction.move(by: CGVector(dx: 0, dy: -30), duration: 0.1)
        let rotate = SKAction.rotate(byAngle: -1/12 * CGFloat(Double.pi), duration: 0.4)
        let outDuration = Double.random(in: 0.2..<2.3)
        let inDuration = Double.random(in: 0.2..<2.3)
        let fadeoutAnime = SKAction.fadeAlpha(to: 0.5, duration: outDuration)
        let fadeinAnime = SKAction.fadeAlpha(to: 1, duration: inDuration)
        let actions = SKAction.sequence([wait, SKAction.group([rotate, down]), SKAction.repeatForever(SKAction.group([fadeoutAnime, fadeinAnime]))])
        gameover_str.run(actions)
        
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 49:
            let newscene = FirstPhaseScene(size: self.scene!.size)
            newscene.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(newscene)
        case 1:
            let newscene = TitleScene(size: self.scene!.size)
            newscene.scaleMode = SKSceneScaleMode.aspectFill
            self.view!.presentScene(newscene)
        default:
            break
        }
    }
}
