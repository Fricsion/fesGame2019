//
//  ViewControllerLoad.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/11.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Cocoa
import Foundation
import SpriteKit

class TravelViewController: NSViewController {
    override func viewDidLoad() {
        let travelView = SKView(frame: self.view.bounds)
        let scene = TravelScene()
        scene.scaleMode = .aspectFit
        travelView.presentScene(scene)
    }
}
