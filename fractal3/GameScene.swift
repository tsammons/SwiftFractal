//
//  GameScene.swift
//  fractal3
//
//  Created by Tyler Sammons on 3/6/17.
//  Copyright (c) 2017 tyler_sammons. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var previous: CGFloat!
    var angleInterval: CGFloat = 25
    var nDepth: Int = 7

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        drawTree(self.view!.frame.width/2, y1: 100, angle: 90, depth: nDepth, a: 0)
    }
    
    
    func drawTree(x1: CGFloat, y1: CGFloat, angle: CGFloat, depth: Int, a: CGFloat){
        if (depth != 0) {
            let x2 = x1 + (cos(angle * CGFloat(M_PI/180.0))*CGFloat(depth)*12)
            let y2 = y1 + (sin(angle * CGFloat(M_PI/180.0))*CGFloat(depth)*12)
            drawLine(x1, y1: y1, x2: x2, y2: y2)
            drawTree(x2, y1: y2, angle: angle-angleInterval - 50*a, depth: depth-1, a: a)
            drawTree(x2, y1: y2, angle: angle+angleInterval - 50*a, depth: depth-1, a: a)
        }
    }
 
    
    func drawLine(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, x1, y1)
        CGPathAddLineToPoint(path, nil, x2, y2)
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = UIColor.whiteColor()
        shape.lineWidth = 2
        addChild(shape)
    }
    


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.removeAllChildren()
            let position :CGPoint = touch.locationInView(view)
            let b = atan2(position.x - self.view!.frame.width/2, (self.view!.frame.height-100) - position.y)
            
            drawTree(self.view!.frame.width/2, y1: 100, angle: 90, depth: nDepth, a: b)
            previous = b
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
       if let touch = touches.first {
            let position :CGPoint = touch.locationInView(view)
            let b = atan2(position.x - self.view!.frame.width/2, (self.view!.frame.height-100) - position.y)
            if (abs(b - previous) > 0.1) {
                self.removeAllChildren()
                drawTree(self.view!.frame.width/2, y1: 100, angle: 90, depth: nDepth, a: b)
                previous = b
            }
        }
    }
   

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
