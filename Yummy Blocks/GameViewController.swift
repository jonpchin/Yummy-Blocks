//
//  GameViewController.swift
//  block_drop
//
//  Created by Jonathan Chin on 12/12/18.
//  Copyright © 2018 goplaychess. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                scene.scaleMode = SKSceneScaleMode.fill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        //if UIDevice.current.userInterfaceIdiom == .phone {
        //    return .allButUpsideDown
        //} else {
        //    return .all
        //}
        return .portrait
    }
    
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
