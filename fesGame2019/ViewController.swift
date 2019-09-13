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
    
    func showMessageWindow() {
        
        let messageView = SKView(frame: NSRect(x: 50, y: 50, width: 400, height: 100))
        let scene = MessageWindow()
        messageView.presentScene(scene)
        self.view.addSubview(messageView)
        
    }
    func showTravelView() {
        let travelView = SKView(frame: self.view.bounds)
        let scene = TravelScene()
        scene.scaleMode = .aspectFit
        travelView.presentScene(scene)
        self.view.addSubview(travelView)
    }
}



