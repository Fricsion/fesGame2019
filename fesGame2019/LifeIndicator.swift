//
//  LifeIndicator.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/08/31.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation
import SpriteKit

class LifeIndicator: SKShapeNode {
    
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
        print(scene)
    }
    
    init(health: CGFloat, parent: SKNode, color: NSColor, linewidth: CGFloat, radius: CGFloat) {
        let path = NSBezierPath.init()
        path.appendArc(withCenter: NSPoint(x: parent.position.x, y: parent.position.y), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi)*health, clockwise: true)
        super.init()
        self.path = path as! CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
