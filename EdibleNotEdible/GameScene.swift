//
//  GameScene.swift
//  EdibleNotEdible
//
//  Created by mac on 18.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit
//import YandexMobileAds

var fail: Int = 0

class GameScene: SimpleScene {

    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    private var viewModel: GameSceneViewModel = GameSceneViewModel()
    var objectNode: SKSpriteNode!
    var tapEdible: SKButton!
    var tapNotEdible: SKButton!
    
    var clockSound = SKAction()
    var winSound = SKAction()
    var failSound = SKAction()
    
    var totalTrueLabelNode = SKLabelNode()
    var scoreLabelNode = SKLabelNode()
    var tutotialNode = SKSpriteNode()
    var timeLabelNode = SKLabelNode()
//    var failScore = SKLabelNode()
    
    var adCount: Int = 0
    
//    var backgroundTexture: SKTexture!
//    var background = SKSpriteNode()
//    var backgroundObject = SKNode()
    
    override func didMove(to view: SKView) {
        if playVolume == true {
         playBackgroundMusic(fileName: "clock.mp3")
        }
//        backgroundTexture = SKTexture(imageNamed: "background")
        
        self.viewModel.updateTimeLabel = {
            self.updateTimeLabel()
//            backgroungMusicPlayer.stop()
//            self.viewModel.changeFailScore(add: true)
        }
        self.viewModel.gameOver = {
            self.failedTimeToSceneBy(nameScene: "FailedTimeScene")
            if playVolume == true {
            backgroungMusicPlayer.stop()
            }
//            self.viewModel.changeFailScore(add: true)
        }

            winSound = SKAction.playSoundFileNamed("win.wav", waitForCompletion: false)
            failSound = SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false)
//        clockSound = SKAction.playSoundFileNamed("clock.wav", waitForCompletion: true)
//        self.playSoundFX(clockSound)
        self.backgroundColor = .defBackground
        
        self.setupUINodes()
        self.setupGamesNodes()

    }
// MARK: - UINode
    
    func setupUINodes() {
        
        // Time Image
        let timeGameImage = SKSpriteNode(imageNamed: "time2")
        timeGameImage.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 190)
        timeGameImage.xScale = 0.22
        timeGameImage.yScale = 0.22
        addChild(timeGameImage)
        
        // Time Label Node
        timeLabelNode = LabelNode(text: String(format: "%.1f", viewModel.initialSeconds), fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 225), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        timeLabelNode.zPosition = 1
        self.addChild(timeLabelNode)
        
        // True Label Node
        scoreLabelNode = LabelNode(text: "\(viewModel.score)", fontSize: 140, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 300), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        scoreLabelNode.zPosition = -1
        self.addChild(scoreLabelNode)
        
        // Total True Label Node
        totalTrueLabelNode = LabelNode(text: "SCORE", fontSize: 50, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 160), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        totalTrueLabelNode.zPosition = -1
        self.addChild(totalTrueLabelNode)
        
        //FailScore
//        failScore = LabelNode(text: "\(viewModel.fail)")
        
        
        //TapEdible
        if edible == true {
            tapEdible = SKButton(imageName: "tapEdible", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                            self.playSoundFX(self.failSound)
                                        }
                                            self.failScore()
                                            
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
            //                            self.tapEdible.removeFromParent()
                                        self.objectNode.isHidden = true
            //                            self.objectNode.removeFromParent()
                                        self.updateLabel()
                                    }
                                })
        } else if softHard == true {
            tapEdible = SKButton(imageName: "tapSoft", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                            self.playSoundFX(self.failSound)
                                        }
                                            self.failScore()
                                            
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
            //                            self.tapEdible.removeFromParent()
                                        self.objectNode.isHidden = true
            //                            self.objectNode.removeFromParent()
                                        self.updateLabel()
                                    }
                                })
        } else if hotCold == true {
            tapEdible = SKButton(imageName: "tapHot", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                            self.playSoundFX(self.failSound)
                                        }
                                            self.failScore()
                                            
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
            //                            self.tapEdible.removeFromParent()
                                        self.objectNode.isHidden = true
            //                            self.objectNode.removeFromParent()
                                        self.updateLabel()
                                    }
                                })
        } else if carnHerb == true {
            tapEdible = SKButton(imageName: "tapHerbivore", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                            self.playSoundFX(self.failSound)
                                        }
                                            self.failScore()
                                            
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
            //                            self.tapEdible.removeFromParent()
                                        self.objectNode.isHidden = true
            //                            self.objectNode.removeFromParent()
                                        self.updateLabel()
                                    }
                                })
        }
            
            tapEdible.position = CGPoint(x: self.frame.midX - 140, y: self.frame.minY + 250)
            tapEdible.xScale = 0.1
            tapEdible.yScale = 0.1
            tapEdible.zPosition = 1
            self.addChild(tapEdible)
        
         
        //TapNotEdible
        if edible == true {
            tapNotEdible = SKButton(imageName: "tapNotEdible", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.playSoundFX(self.failSound)
                                            }
            //                                self.tapNotEdible.removeFromParent()
                                            self.failScore()
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
                                        
                                        self.objectNode.isHidden = true
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if softHard == true {
            tapNotEdible = SKButton(imageName: "tapHard", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.playSoundFX(self.failSound)
                                            }
            //                                self.tapNotEdible.removeFromParent()
                                            self.failScore()
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
                                        
                                        self.objectNode.isHidden = true
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if hotCold == true {
            tapNotEdible = SKButton(imageName: "tapCold", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.playSoundFX(self.failSound)
                                            }
            //                                self.tapNotEdible.removeFromParent()
                                            self.failScore()
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
                                        
                                        self.objectNode.isHidden = true
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if carnHerb == true {
            tapNotEdible = SKButton(imageName: "tapCarnivore", buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                        self.playSoundFX(self.winSound)
                                        }
                                        self.createNewObject()
                                        self.viewModel.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                        //                self.viewModel.changeFailScore(add: true)
                                        self.viewModel.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.playSoundFX(self.failSound)
                                            }
            //                                self.tapNotEdible.removeFromParent()
                                            self.failScore()
                                            self.failedToSceneBy(nameScene: "FailedScene")
                                        }
                                        
                                        self.objectNode.isHidden = true
                                        self.updateLabel()
                                    }
                                    
                                })
        }
            
        
            tapNotEdible.position = CGPoint(x: self.frame.midX + 140, y: self.frame.minY + 250)
            tapNotEdible.xScale = 0.1
            tapNotEdible.yScale = 0.1
            
            tapNotEdible.zPosition = 1
            self.addChild(tapNotEdible)
        

 // MARK: - Instruction
        //Tutorial Button
        let tutorialFinished = UserDefaults.standard.bool(forKey: "tutorialFinished")
        
        tutotialNode = ButtonNode(imageNode: "instruction", position: CGPoint(x: self.frame.midX, y: self.frame.midY), xScale: 0.4, yScale: 0.4)
        tutotialNode.zPosition = 5
        tutotialNode.isHidden = tutorialFinished
        self.addChild(tutotialNode)
    
        createNewObject()
    }

    
    //newScore
    func updateLabel() {
        if scoreLabelNode.parent != nil {
            self.scoreLabelNode.removeFromParent()
            self.scoreLabelNode = LabelNode(text: "\(viewModel.score)", fontSize: 140, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 300), fontColor: .textColor)
            self.zPosition = -1
            self.addChild(scoreLabelNode)
        }
        self.update(0)
    }
    
    func updateTimeLabel() {
        if timeLabelNode.parent != nil {
            self.timeLabelNode.removeFromParent()
            self.timeLabelNode = LabelNode(text: String(format: "%.1f", viewModel.initialSeconds), fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 225), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            self.timeLabelNode.zPosition = 1
            self.addChild(timeLabelNode)
        }
        self.update(1)
    }
    
    // createNewObject
    func createNewObject() {
        if self.objectNode != nil, self.objectNode.parent != nil {
            self.objectNode.removeFromParent()
            
        }
        
        if edible == true {
            var newObj = self.viewModel.objectsArray.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
            if viewModel.currentNode != nil {
                while newObj.name == viewModel.currentNode!.name {
                    newObj = self.viewModel.objectsArray.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
                }
            }
            self.viewModel.currentNode = newObj
            self.objectNode = ButtonNode(imageNode: self.viewModel.currentNode!.name, position: CGPoint(x: self.frame.midX, y: self.frame.midY + 120), xScale: 0.7, yScale: 0.7)
            self.objectNode.zPosition = -1
            self.addChild(objectNode)
            self.update(0)
        } else if hotCold == true {
            var newObj = self.viewModel.objectsArrayHotCold.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
            if viewModel.currentNode != nil {
                while newObj.name == viewModel.currentNode!.name {
                    newObj = self.viewModel.objectsArrayHotCold.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
                }
            }
            self.viewModel.currentNode = newObj
            self.objectNode = ButtonNode(imageNode: self.viewModel.currentNode!.name, position: CGPoint(x: self.frame.midX, y: self.frame.midY + 120), xScale: 0.7, yScale: 0.7)
            self.objectNode.zPosition = -1
            self.addChild(objectNode)
            self.update(0)
        } else if softHard == true {
            var newObj = self.viewModel.objectsArrayHardSoft.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
            if viewModel.currentNode != nil {
                while newObj.name == viewModel.currentNode!.name {
                    newObj = self.viewModel.objectsArrayHardSoft.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
                }
            }
            self.viewModel.currentNode = newObj
            self.objectNode = ButtonNode(imageNode: self.viewModel.currentNode!.name, position: CGPoint(x: self.frame.midX, y: self.frame.midY + 120), xScale: 0.7, yScale: 0.7)
            self.objectNode.zPosition = -1
            self.addChild(objectNode)
            self.update(0)
        } else if carnHerb == true {
            var newObj = self.viewModel.objectsArrayCarnivorous.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
            if viewModel.currentNode != nil {
                while newObj.name == viewModel.currentNode!.name {
                    newObj = self.viewModel.objectsArrayCarnivorous.randomElement() ?? ObjectModel(name: "apple", isEdible: true)
                }
            }
            self.viewModel.currentNode = newObj
            self.objectNode = ButtonNode(imageNode: self.viewModel.currentNode!.name, position: CGPoint(x: self.frame.midX, y: self.frame.midY + 120), xScale: 0.7, yScale: 0.7)
            self.objectNode.zPosition = -1
            self.addChild(objectNode)
            self.update(0)
        }
            
    }
    
    func setupGamesNodes() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if tutotialNode.contains(location) {

                tutotialNode.isHidden = true
                UserDefaults.standard.set(true, forKey: "tutorialFinished")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func failScore() {

        fail += 1
        if fail >= 4 {
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentInterstitial"), object: nil)
            fail = 0
        }
    }    
    func failedСhoice() {
    }
    override func update(_ currentTime: TimeInterval) {
    }
    

}
