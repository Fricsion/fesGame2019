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

    init(parent: SKSpriteNode, radius: Int) {
        let path = NSBezierPath.init()
        path.appendArc(withCenter: parent.position, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        super.init()
        self.path = path.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func updatePosition(parent: SKSpriteNode) {
        self.position = parent.position
    }
    
    func updateHealth(health: Float) {
    }
}

extension NSBezierPath {
    
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            
            switch type {
            case .moveTo:
                path.move(to: points[0])
                
            case .lineTo:
                path.addLine(to: points[0])
                
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
                
            case .closePath:
                path.closeSubpath()
                
            @unknown default:
                break
            }
        }
        return path
    }
}
