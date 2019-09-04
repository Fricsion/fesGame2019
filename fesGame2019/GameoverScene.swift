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
        
        let gameover_str = SKLabelNode()
        gameover_str.text = "Game Over"
        gameover_str.position = CGPoint(x: self.view!.bounds.maxX/2, y: (self.view!.bounds.maxY)/2)
        gameover_str.fontSize = 40
        gameover_str.fontName = "Chalkduster"
        self.addChild(gameover_str)
    }
}
