//
//  ViewController.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit


class ViewController: NSViewController {

//    @IBOutlet var skView: SKView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let view = self.skView {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "TitleScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//    }
    
    override func viewDidLoad() {
        let view = self.view as! SKView
        let scene = TitleScene()
        scene.scaleMode = .aspectFill
        scene.size = view.frame.size
        view.presentScene(scene)
        view.showsFPS = true
        view.showsNodeCount = true
    }
}



