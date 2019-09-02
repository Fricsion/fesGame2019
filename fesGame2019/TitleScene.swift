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
        
        let gametitle_str = SKLabelNode()
        gametitle_str.text = "Jellies of War"
        gametitle_str.fontSize = 40
        gametitle_str.fontName = "Chalkduster"
        gametitle_str.position = CGPoint(x: 0, y: 0)
        self.addChild(gametitle_str)

        
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
