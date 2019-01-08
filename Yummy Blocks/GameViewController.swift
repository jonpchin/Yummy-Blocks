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
        
        showMainMenu()
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    // TODO: Play some music and add some bouncing/floating blocks in the main menu
    func showMainMenu(){

        let startBtn = MainMenuButton(frame: CGRect(x:(UIScreen.main.bounds.size.width  - 240) / 2,
                                              y:(UIScreen.main.bounds.size.height - 40) / 2, width:240, height:40))
        startBtn.whenButtonIsClicked { [unowned self] in
            self.startGame()
            startBtn.isHidden = true
        }
        startBtn.layer.borderColor = UIColor.black.cgColor
        startBtn.layer.borderWidth = 2
        startBtn.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        startBtn.tintColor = UIColor.black
        startBtn.setTitle("Start", for: UIControl.State.normal)

        self.view.addSubview(startBtn)
    }
    
    func startGame(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                scene.scaleMode = SKSceneScaleMode.fill
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
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
