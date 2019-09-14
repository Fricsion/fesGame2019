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

    override init() {
        let path = NSBezierPath.init()
        path.appendArc(withCenter: CGPoint(x: 80, y: 80), radius: CGFloat(50), startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        super.init()
        self.path = path.cgPath
        self.strokeColor = NSColor.green
        self.lineWidth = 30
        self.lineCap = .round
        
        self.alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func updateHealth(health: Int) {
        let changedPath = NSBezierPath()
        print(Double(health)/100.0)
        let endAngle: CGFloat = CGFloat(-360 * health/100)
        changedPath.appendArc(withCenter: CGPoint(x: 80, y: 80), radius: CGFloat(50), startAngle: 0, endAngle: endAngle, clockwise: true)
        self.path = changedPath.cgPath
        
        let popup = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
        let fadeout = SKAction.fadeAlpha(to: 0.5, duration: 1.0)
        self.run(SKAction.sequence([popup, fadeout]))
        let action = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
        self.run(SKAction.sequence([action, action.reversed()]))
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
