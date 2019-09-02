//
//  GameScene.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = Player(def_pos: CGPoint(x: 490.0, y: 400.0))
    var moveDistanceX = 0
    var moveDistanceY = 0
    
    override func didMove(to view: SKView) {
        
        player.setScene(scene: self)
        self.addChild(player)
        
        let enemy = Enemy(def_pos: CGPoint(x: 0.0, y: 200.0))
        enemy.setScene(scene: self)
        self.addChild(enemy)

    }

    override func keyDown(with event: NSEvent) {
        
        switch event.keyCode {
        case 13:
            moveDistanceY = 5
        case 0:
            moveDistanceX = -5
        case 1:
            moveDistanceY = -5
        case 2:
            moveDistanceX = 5
        default:
            break
        }
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13, 1:
            moveDistanceY = 0
        case 0, 2:
            moveDistanceX = 0
        default:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.player.move(x: moveDistanceX, y: moveDistanceY)
        self.player.update()
    }
}
