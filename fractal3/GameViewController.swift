//
//  GameViewController.swift
//  fractal3
//
//  Created by Tyler Sammons on 3/6/17.
//  Copyright (c) 2017 tyler_sammons. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var taps = 0
    var scene:GameScene!
    @IBOutlet weak var angle: UISlider!
    @IBOutlet weak var depth: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = GameScene(size:CGSizeMake(self.view.frame.width, self.view.frame.height))
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        self.angle.hidden = true
        self.depth.hidden = true

        /*
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
         
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
        */
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
        /*
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func tapHide(sender: AnyObject) {
        taps += 1
        if (taps%2 == 1) {
            self.angle.hidden = false
            self.depth.hidden = false
        }
        else {
            self.angle.hidden = true
            self.depth.hidden = true
        }
    }

    @IBAction func changeAngle(sender: AnyObject) {
        scene.angleInterval = CGFloat(angle.value)
        scene.removeAllChildren()
        scene.drawTree(scene.view!.frame.width/2, y1: 100, angle: 90, depth: scene.nDepth, a: 0)
    }
    
    
    @IBAction func changeDepth(sender: AnyObject) {
        scene.nDepth = Int(depth.value)
        scene.removeAllChildren()
        scene.drawTree(scene.view!.frame.width/2, y1: 100, angle: 90, depth: scene.nDepth, a: 0)
    }

}
