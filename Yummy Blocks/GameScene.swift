//
//  GameScene.swift
//  block_drop
//
//  Created by Jonathan Chin on 12/12/18.
//  Copyright © 2018 goplaychess. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    // The currently falling block
    private var blockNode : SKSpriteNode?
    // The next block to fall
    private var nextBlock : SKSpriteNode?
    var viewController: UIViewController?

    // The image file of the next block to fall
    var imageName:String = ""
    var counter:Int = 300
    var timer = Timer()
    
    let APPLE_TITLE = "apple.png"
    let AVOCADO_TITLE = "avocado.png"
    let BLACKBERRY_TITLE = "blackberry.png"
    let BLUEBERRY_TITLE = "blueberry.png"
    let BROWNIE_TITLE = "brownie.png"
    let CARAMEL_TITLE = "caramel.png"
    let CHOCOLATEPUDDING_TITLE = "chocolatepudding.png"
    let COCONUT_TITLE = "coconut.png"
    let COFFEE_TITLE = "coffee.png"
    let GRAPE_TITLE = "grape.png"
    let HONEYDEW_TITLE = "honeydew.png"
    let ICECREAM_TITLE = "icecream.png"
    let KALE_TITLE = "kale.png"
    let KIWI_TITLE = "kiwi.png"
    let LEMON_TITLE = "lemon.png"
    let LIQUORICE_TITLE = "liquorice.png"
    let LYCHEE_TITLE = "lychee.png"
    let MANGO_TITLE = "mango.png"
    let OYSTER_TITLE = "oyster.png"
    let PASSIONFRUIT_TITLE = "passionfruit.png"
    let PINEAPPLE_TITLE = "pineapple.png"
    let SALT_TITLE = "salt.png"
    let STRAWBERRY_TITLE = "strawberry.png"
    let SUGAR_TITLE = "sugar.png"
    let WATER_TITLE = "water.png"    
    
    lazy var blockElements : [String] = {
        [APPLE_TITLE, AVOCADO_TITLE, BLACKBERRY_TITLE, BLUEBERRY_TITLE, BROWNIE_TITLE, CARAMEL_TITLE, CHOCOLATEPUDDING_TITLE, COCONUT_TITLE, COFFEE_TITLE,
         GRAPE_TITLE, HONEYDEW_TITLE, ICECREAM_TITLE, KALE_TITLE, KIWI_TITLE, LEMON_TITLE, LIQUORICE_TITLE, LYCHEE_TITLE, MANGO_TITLE, OYSTER_TITLE,
         PASSIONFRUIT_TITLE, PINEAPPLE_TITLE, SALT_TITLE, STRAWBERRY_TITLE, SUGAR_TITLE, WATER_TITLE]
    }()
    
    // Keeps track of the number of collisions for each block type
    lazy  var collisionCounter: [String: Int] = {
        [APPLE_TITLE:0, AVOCADO_TITLE:0, BLACKBERRY_TITLE:0, BLUEBERRY_TITLE:0 , BROWNIE_TITLE:0, CARAMEL_TITLE:0, CHOCOLATEPUDDING_TITLE:0,
         COCONUT_TITLE:0, COFFEE_TITLE:0, GRAPE_TITLE:0, HONEYDEW_TITLE:0, ICECREAM_TITLE:0, KALE_TITLE:0, KIWI_TITLE:0, LEMON_TITLE:0, LIQUORICE_TITLE:0,
         LYCHEE_TITLE:0, MANGO_TITLE:0, OYSTER_TITLE:0, PASSIONFRUIT_TITLE:0, PINEAPPLE_TITLE:0, SALT_TITLE:0,  STRAWBERRY_TITLE:0, SUGAR_TITLE:0, WATER_TITLE:0]
    }()
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var floor: SKSpriteNode!
    @IBOutlet weak var points: SKLabelNode!
    @IBOutlet weak var level: SKLabelNode!
    
    enum ColliderType: UInt32 {
        case Floor = 1
        case Apple = 2
        case Avocado = 4
        case BlackBerry =  8
        case Blueberry = 16
        case Brownie = 32
        case Caramel = 64
        case Chocolatepudding = 128
        case Coconut = 256
        case Coffee = 512
        case Grape = 1024
        case Honeydew = 2048
        case Icecream = 4096
        case Kale = 8192
        case Kiwi = 16384
        case Lemon = 32768
        case Liquorice = 65536
        case Lychee = 131072
        case Mango = 262144
        case Oyster = 524288
        case Passionfruit = 1048576
        case Pineapple = 2097152
        case Salt = 4194304
        case Strawberry = 8388608
        case Sugar = 16777216
        case Water = 33554432
    }

    func getCollidableBlockTypes(blockType : String) -> UInt32{
        var result:UInt32 = 0
        
        switch blockType {
        case APPLE_TITLE:
            result = ColliderType.Apple.rawValue
        case AVOCADO_TITLE:
            result = ColliderType.Avocado.rawValue
        case BLACKBERRY_TITLE:
            result = ColliderType.BlackBerry.rawValue
        case BLUEBERRY_TITLE:
            result = ColliderType.Blueberry.rawValue
        case BROWNIE_TITLE:
            result = ColliderType.Brownie.rawValue
        case CARAMEL_TITLE:
            result = ColliderType.Caramel.rawValue
        case CHOCOLATEPUDDING_TITLE:
            result =  ColliderType.Chocolatepudding.rawValue
        case COCONUT_TITLE:
            result = ColliderType.Coconut.rawValue
        case COFFEE_TITLE:
            result = ColliderType.Coffee.rawValue
        case GRAPE_TITLE:
            result = ColliderType.Grape.rawValue
        case HONEYDEW_TITLE:
            result = ColliderType.Honeydew.rawValue
        case ICECREAM_TITLE:
            result = ColliderType.Icecream.rawValue
        case KALE_TITLE:
            result = ColliderType.Kale.rawValue
        case KIWI_TITLE:
            result = ColliderType.Kiwi.rawValue
        case LEMON_TITLE:
            result = ColliderType.Lemon.rawValue
        case LIQUORICE_TITLE:
            result = ColliderType.Liquorice.rawValue
        case LYCHEE_TITLE:
            result = ColliderType.Lychee.rawValue
        case MANGO_TITLE:
            result = ColliderType.Mango.rawValue
        case OYSTER_TITLE:
            result = ColliderType.Oyster.rawValue
        case PASSIONFRUIT_TITLE:
            result = ColliderType.Passionfruit.rawValue
        case PINEAPPLE_TITLE:
            result = ColliderType.Pineapple.rawValue
        case SALT_TITLE:
            result = ColliderType.Salt.rawValue
        case STRAWBERRY_TITLE:
            result = ColliderType.Strawberry.rawValue
        case SUGAR_TITLE:
            result = ColliderType.Sugar.rawValue
        case WATER_TITLE:
            result = ColliderType.Water.rawValue
        default:
            print("Error: No match for collidable block found")
        }
        
        return result
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
    
    func createNewBlock(atPoint pos : CGPoint){
  
        blockNode = SKSpriteNode(imageNamed: imageName)
        blockNode!.position = CGPoint(x: pos.x, y: 640)
        
        blockNode?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        
        blockNode!.physicsBody?.categoryBitMask = getCollidableBlockTypes(blockType: imageName)
        blockNode!.physicsBody?.collisionBitMask = ColliderType.Apple.rawValue | ColliderType.Avocado.rawValue | ColliderType.BlackBerry.rawValue |
            ColliderType.Blueberry.rawValue | ColliderType.Brownie.rawValue | ColliderType.Caramel.rawValue | ColliderType.Chocolatepudding.rawValue |
            ColliderType.Coconut.rawValue | ColliderType.Coffee.rawValue | ColliderType.Grape.rawValue | ColliderType.Honeydew.rawValue |
            ColliderType.Icecream.rawValue | ColliderType.Kale.rawValue | ColliderType.Kiwi.rawValue | ColliderType.Lemon.rawValue |
            ColliderType.Liquorice.rawValue | ColliderType.Lychee.rawValue | ColliderType.Mango.rawValue | ColliderType.Oyster.rawValue |
            ColliderType.Passionfruit.rawValue | ColliderType.Pineapple.rawValue | ColliderType.Salt.rawValue | ColliderType.Strawberry.rawValue |
            ColliderType.Sugar.rawValue  | ColliderType.Water.rawValue  | ColliderType.Floor.rawValue
        
        blockNode!.physicsBody?.contactTestBitMask = getCollidableBlockTypes(blockType: imageName)
        
        blockNode!.physicsBody?.isDynamic = true
        blockNode!.name = imageName

        moveBlockNodeDown(touchedLocation: pos, yCoord: -640)
        generateNextBlock()
        
        // Game is over if there are more then 70 blocks on the screen
        if self.children.count > 70 {
            let tempLevel = level.text!.components(separatedBy: " ")
            let tempPoints = points.text!.components(separatedBy: " ")
            playSound(soundFile: "game_over")
            let gameViewController = GameViewController()
            let tempScore = String((20 * Int(tempLevel[1])!) + Int(tempPoints[1])!)
        
            gameViewController.recentScore = tempScore
            
            let highestScore = UserDefaults.standard.string(forKey: "Score")
            
            if let tempScoreInt = Int(tempScore) {
                if let highestScoreInt = Int(highestScore!) {
                    if tempScoreInt > highestScoreInt || highestScore == nil {
                        UserDefaults.standard.set(tempScore, forKey: "Score")
                    }
                }
            }
            
            self.view?.window?.rootViewController = gameViewController
        }
    }
    
    // Called once when game is initialized
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.backgroundColor = .white

        points = self.childNode(withName: "Points") as? SKLabelNode
        points.text = "Points 0"
 
        level = self.childNode(withName: "Level") as? SKLabelNode
        level.text = "Level 1"
        
        generateNextBlock()
    }
    
    func generateNextBlock(){
        
        if nextBlock != nil {
            nextBlock!.removeFromParent()
        }

        imageName = blockElements.randomElement()!
        
        nextBlock = SKSpriteNode(imageNamed: imageName)
        nextBlock!.position = CGPoint(x: -300, y: 600)
        nextBlock!.name = imageName
        nextBlock!.setScale(0.5)

        self.addChild(nextBlock!)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        blockNode!.removeAllActions()
        let nodeAName = contact.bodyA.node!.name!

        let object2 = contact.bodyA.node as! SKSpriteNode
        let object1 = contact.bodyB.node as! SKSpriteNode
        
        let changeColorAction: SKAction = SKAction.run { () -> Void in
            object2.alpha = 0.5
            object1.alpha = 0.5
        }
        
        let changeBackAction: SKAction = SKAction.run { () -> Void in
            object2.alpha = 1.0
            object1.alpha = 1.0
        }
        
        let waitAction: SKAction = SKAction.wait(forDuration: 0.2)
   
        let combined: SKAction = SKAction.sequence(
            [   changeColorAction,
                waitAction,
                changeBackAction,
                waitAction,
                changeColorAction,
                waitAction,
                changeBackAction,
                waitAction,
                changeColorAction,
                waitAction,
                changeBackAction,
                changeColorAction,
                waitAction,
                changeBackAction,
                changeColorAction,
                waitAction,
                changeBackAction])
        
        run(combined)

        let tempLevel = level.text!.components(separatedBy: " ")
        let levelNum = Int(tempLevel[1])!
        
        if collisionCounter[nodeAName]! >= levelNum - 1{
            object1.removeFromParent()
            object2.removeFromParent()
            collisionCounter[nodeAName] = 0
        }else{
            collisionCounter[nodeAName]! += 1
        }
 
        let tempNodeAName = nodeAName.components(separatedBy: ".")
        let tempNodeNoExt    = tempNodeAName[0]
        playSound(soundFile: tempNodeNoExt)
        
        let tempPoints = points.text!.components(separatedBy: " ")
        let numberOfPoints =  Int(tempPoints[1])!
        
        if numberOfPoints >= 20 {
            level.text = "Level " + String(levelNum  + 1)
            points.text = "Points 0"
        }else{
            points.text = tempPoints[0] + " " + String(numberOfPoints + 1)
        }
    }
    
    func backgroundTileDefinition(key: String) -> SKTileDefinition {
        guard let backgroundLayer = childNode(withName: "worldMapNode") as? SKTileMapNode else {
            fatalError("Background node not loaded")
        }
        
        guard let backgroundTile = backgroundLayer.tileSet.tileGroups.first(where: {$0.name == key}) else {
            fatalError("TileSet not found")
        }
        
        guard let backgroundTileSetRule = backgroundTile.rules.first(where: {$0.name == key}) else {
            fatalError("Tileset rule not found")
        }
        
        guard let backgroundTileDefinition = backgroundTileSetRule.tileDefinitions.first(where: {$0.name == key}) else {
            fatalError("Tile definition not found")
        }
        
        return backgroundTileDefinition
    }
    
    func moveBlockNodeDown(touchedLocation: CGPoint, yCoord: CGFloat)
    {
        blockNode?.removeFromParent()
        let tempDuration:Double = Double((blockNode!.position.y + 960) / 320)
        let action = SKAction.move(to: CGPoint(x: touchedLocation.x, y: yCoord), duration: tempDuration)
        blockNode?.run(action)
        self.addChild(blockNode!)
    }
    func touchDown(atPoint pos : CGPoint) {
        
        var tempPos:CGPoint = CGPoint(x: pos.x, y: pos.y)
        
        if pos.x > 360 {
            tempPos.x = 360
        }
        
        if pos.x < -360 {
            tempPos.x = -360
        }
        
        createNewBlock(atPoint: tempPos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
