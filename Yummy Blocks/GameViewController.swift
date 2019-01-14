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
import AVFoundation

class GameViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var recentScore: String?
    
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(soundFile: "arcade_game")
        showMainMenu()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    func showMainMenu(){
        
        let diff:CGFloat = 30.0
        var floatingPineapple : UIImageView
        floatingPineapple  = UIImageView(frame:CGRect(x:UIScreen.main.bounds.size.width/2,
                                                  y: UIScreen.main.bounds.size.height/4, width:64, height:64))
        var floatingIcecream : UIImageView
        floatingIcecream  = UIImageView(frame:CGRect(x:UIScreen.main.bounds.size.width/2-(diff*3),
                                                      y: UIScreen.main.bounds.size.height/4-diff, width:64, height:64))
        
        let highestScoreBoard = UILabel(frame: CGRect(x:(UIScreen.main.bounds.size.width - 120) / 2,
                                               y:(UIScreen.main.bounds.size.height + 100) / 2, width:200, height:40))
        
        let recentScoreBoard = UILabel(frame: CGRect(x:(UIScreen.main.bounds.size.width - 120) / 2,
                                               y:(UIScreen.main.bounds.size.height + 150) / 2, width:200, height:40))
        
        let buttonWidth:CGFloat = 240
        let buttonHeight:CGFloat = 40
        let playBtn = MainMenuButton(frame: CGRect(x:(UIScreen.main.bounds.size.width  - buttonWidth) / 2,
                                              y:(UIScreen.main.bounds.size.height - buttonHeight) / 2, width:buttonWidth, height:buttonHeight))
        playBtn.whenButtonIsClicked { [unowned self, floatingPineapple, floatingIcecream, highestScoreBoard] in
            self.playSound(soundFile: "zapTwoTone2")
            self.startGame()
            playBtn.isHidden = true
            floatingPineapple.isHidden = true
            floatingIcecream.isHidden = true
            highestScoreBoard.isHidden = true
            recentScoreBoard.isHidden = true
        }
        playBtn.layer.borderColor = UIColor.black.cgColor
        playBtn.layer.borderWidth = 2
        playBtn.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        playBtn.tintColor = UIColor.black
        playBtn.setTitle("Play", for: UIControl.State.normal)

        self.view.addSubview(playBtn)
        
        floatingPineapple.image = UIImage(named: "pineapple")
        floatingIcecream.image = UIImage(named: "icecream")
       
        let oldCenterPineapple = floatingPineapple.center
        let newCenterPineapple = CGPoint(x: oldCenterPineapple.x, y: oldCenterPineapple.y-diff)
        let oldCenterIcecream = floatingIcecream.center
        let newCenterIcecream = CGPoint(x: oldCenterIcecream.x, y: oldCenterIcecream.y+diff)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            floatingPineapple.center = newCenterPineapple
            floatingIcecream.center = newCenterIcecream
        }) { (success: Bool) in
            //print("Done moving image")
        }
        
        let highestScore = UserDefaults.standard.string(forKey: "Score")
        highestScoreBoard.text = "Highest Score: 0"
        recentScoreBoard.text = "Recent Score: N/A"
        
        if highestScore != nil {
            highestScoreBoard.text = "Highest Score: " + highestScore!
        }
        
        if recentScore != nil{
            recentScoreBoard.text = "Recent Score: " + recentScore!
        }
        
        self.view.addSubview(floatingPineapple)
        self.view.addSubview(floatingIcecream)
        self.view.addSubview(highestScoreBoard)
        self.view.addSubview(recentScoreBoard)
    }

    func playSound(soundFile : String) {
        let path = Bundle.main.path(forResource: soundFile, ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
            print("couldn't load mp3 file")
        }
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
