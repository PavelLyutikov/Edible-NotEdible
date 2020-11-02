//
//  FailedTimeScene.swift
//  EdibleNotEdible
//
//  Created by mac on 03.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit

class FailedTimeScene: SimpleScene {
    
    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    let bestScoreEdible = UserDefaults.standard.integer(forKey: "bestScoreEdible")
    let bestScoreHotCold = UserDefaults.standard.integer(forKey: "bestScoreHotCold")
    let bestScoreSoftHard = UserDefaults.standard.integer(forKey: "bestScoreSoftHard")
    let bestScoreCarnHarb = UserDefaults.standard.integer(forKey: "bestScoreCarnHarb")
    
    private var viewModel: GameSceneViewModel = GameSceneViewModel()
    var returnButton: SKButton!
    var homeButton : SKButton!
    
    var tapSound = SKAction()
    var timeIsUpSound = SKAction()

    var backgroundTexture: SKTexture!
    var background = SKSpriteNode()
    var backgroundObject = SKNode()

    override func didMove(to view: SKView) {
        backgroundTexture = SKTexture(imageNamed: "background")
        
        tapSound = SKAction.playSoundFileNamed("tap.flac", waitForCompletion: false)
        timeIsUpSound = SKAction.playSoundFileNamed("time_is_up.wav", waitForCompletion: true)
        if playVolume == true {
        self.playSoundFX(timeIsUpSound)
        }
        
        self.backgroundColor = .defBackground
        self.setupUINodes()
        self.createObject()
        self.createGame()
    }
    
    // MARK: - AnimationBackground
       func createObject() {
           self.addChild(backgroundObject)
       }
       func createGame() {
           createBackground()
       }
       func createBackground() {
           let moveBg = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height, duration: 20)
           let replaceBg = SKAction.moveBy(x: 0, y: backgroundTexture.size().height, duration: 0)
           let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, replaceBg]))
           
           for i in 0..<3 {
               background = SKSpriteNode(texture: backgroundTexture)
               background.position = CGPoint(x: frame.midX, y: backgroundTexture.size().height * CGFloat(i))
               background.size.width = self.frame.width
               background.run(moveBgForever)
               background.zPosition = -1
               backgroundObject.addChild(background)
           }
       }
    
    func setupUINodes() {
    
        //GameOverImage
        let gameOverImage = SKSpriteNode(imageNamed: "gameOverTime")
            gameOverImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 250)
            gameOverImage.xScale = 0.25
            gameOverImage.yScale = 0.25
        gameOverImage.zPosition = 1
        self.addChild(gameOverImage)
        
        //Best Score Label
        let bestScoreLabelNode = LabelNode(text: "BEST SCORE:", fontSize: 60, position: CGPoint(x: self.frame.midX - 60, y: self.frame.midY), fontColor: .textColor)
        bestScoreLabelNode.zPosition = 1
        self.addChild(bestScoreLabelNode)
        
        //High Score Label
        if edible == true {
             let highScoreLabelNode = LabelNode(text: String(bestScoreEdible), fontSize: 60, position: CGPoint(x: self.frame.midX + 180, y: self.frame.midY), fontColor: .textColor)
             highScoreLabelNode.zPosition = 1
             self.addChild(highScoreLabelNode)
        } else if hotCold == true {
             let highScoreLabelNode = LabelNode(text: String(bestScoreHotCold), fontSize: 60, position: CGPoint(x: self.frame.midX + 180, y: self.frame.midY), fontColor: .textColor)
             highScoreLabelNode.zPosition = 1
             self.addChild(highScoreLabelNode)
        } else if softHard == true {
             let highScoreLabelNode = LabelNode(text: String(bestScoreSoftHard), fontSize: 60, position: CGPoint(x: self.frame.midX + 180, y: self.frame.midY), fontColor: .textColor)
             highScoreLabelNode.zPosition = 1
             self.addChild(highScoreLabelNode)
        } else if carnHerb == true {
             let highScoreLabelNode = LabelNode(text: String(bestScoreCarnHarb), fontSize: 60, position: CGPoint(x: self.frame.midX + 180, y: self.frame.midY), fontColor: .textColor)
             highScoreLabelNode.zPosition = 1
             self.addChild(highScoreLabelNode)
        }
        
        //Best Score Label
        let failedBestScoreLabelNode = LabelNode(text: "SCORE:", fontSize: 60, position: CGPoint(x: self.frame.midX - 50, y: self.frame.midY - 100), fontColor: .textColor)
        failedBestScoreLabelNode.zPosition = 1
        self.addChild(failedBestScoreLabelNode)
        
        //High Score Label
        let failedScore = UserDefaults.standard.integer(forKey: "failedScore")
        let failedScoreLabelNode = LabelNode(text: String(failedScore), fontSize: 60, position: CGPoint(x: self.frame.midX + 170, y: self.frame.midY - 100), fontColor: .textColor)
        failedScoreLabelNode.zPosition = 1
        self.addChild(failedScoreLabelNode)
        
        //HomeButton
        homeButton = SKButton(imageName: "home", buttonAction: {
            if playVolume == true {
            self.playSoundFX(self.tapSound)
            }
            self.changeToSceneBy(nameScene: "MenuScene")
        })
            homeButton.position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY - 250)
            homeButton.xScale = 0.2
            homeButton.yScale = 0.2
            homeButton.zPosition = 1
        self.addChild(homeButton)
            
        //ReturnButton
        returnButton = SKButton(imageName: "return", buttonAction: {
            if playVolume == true {
            self.playSoundFX(self.tapSound)
            }
            self.changeToSceneBy(nameScene: "GameScene")
        })
            returnButton.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 250)
            returnButton.xScale = 0.2
            returnButton.yScale = 0.2
            returnButton.zPosition = 1
        self.addChild(returnButton)
        
        //BackgroundMini
        let backgroundMini = SKSpriteNode(imageNamed: "backgroundMini3")
            backgroundMini.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 120)
            backgroundMini.xScale = 0.35
            backgroundMini.yScale = 0.35
        backgroundMini.zPosition = 0
        self.addChild(backgroundMini)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        }
}
