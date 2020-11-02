//
//  MenuScene.swift
//  EdibleNotEdible
//
//  Created by mac on 20.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit
import StoreKit
//import GameplayKit



class MenuScene: SimpleScene {
    
    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    let bestScoreEdible = UserDefaults.standard.integer(forKey: "bestScoreEdible")
    let bestScoreHotCold = UserDefaults.standard.integer(forKey: "bestScoreHotCold")
    let bestScoreSoftHard = UserDefaults.standard.integer(forKey: "bestScoreSoftHard")
    let bestScoreCarnHarb = UserDefaults.standard.integer(forKey: "bestScoreCarnHarb")
    
    var highScoreLabelNode: SKLabelNode!
    let totalSize = UIScreen.main.bounds.size
    
    var backgroundTexture: SKTexture!
    var background = SKSpriteNode()
    var backgroundObject = SKNode()
    var playButton: SKButton!
    
    var musicOffButton: SKButton!
    var musicOnButton: SKButton!

    var tapSound = SKAction()

//MARK: - DidMove
    override func didMove(to view: SKView) {
        backgroundTexture = SKTexture(imageNamed: "background")
        self.backgroundColor = .defBackground
        
//        tapSound = SKAction.playSoundFileNamed("tap.flac", waitForCompletion: false)
        
        setupUI()
        createObject()
        createGame()
        spawnButtonLevel()
        spawnBestScore()
        spawnPlay()
        rateMeButton()
        if playVolume == true {
            self.spawnMusicOffButton()
        } else if playVolume == false {
            self.spawnMusicOnButton()
        }
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
    
 // MARK: - ButtonNode
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func startGame() {
        self.changeToSceneBy(nameScene: "GameScene")
    }

//MARK: - PlayButton
    func spawnPlay() {
        if edible == true {
            spawnPlayButtonEdible()
        } else if hotCold == true {
            spawnPlayButtonHotCold()
        } else if softHard == true {
            spawnPlayButtonSoftHard()
        } else if carnHerb == true {
            spawnPlayButtonCarnHerb()
        }
    }
    func spawnPlayButtonEdible() {
        
            playButton = SKButton(imageName: "play2", buttonAction: {
                    
                    if playVolume == true {
                    self.playSoundFX(self.tapSound)
                    }

                    self.changeToSceneBy(nameScene: "GameScene")
                })
            
            playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
            playButton.xScale = 0.1
            playButton.yScale = 0.1
            playButton.zPosition = 1
            self.addChild(playButton)
    }
    func spawnPlayButtonCarnHerb() {
        playButton = SKButton(imageName: "grassMeatPlay", buttonAction: {
                
                if playVolume == true {
                self.playSoundFX(self.tapSound)
                }
     
                self.changeToSceneBy(nameScene: "GameScene")
            })
        
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playButton.xScale = 0.1
        playButton.yScale = 0.1
        playButton.zPosition = 1
        self.addChild(playButton)
    }
    
    func spawnPlayButtonHotCold() {
        playButton = SKButton(imageName: "hotColdPlay", buttonAction: {
                
                if playVolume == true {
                self.playSoundFX(self.tapSound)
                }

                self.changeToSceneBy(nameScene: "GameScene")
            })
        
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playButton.xScale = 0.1
        playButton.yScale = 0.1
        playButton.zPosition = 1
        self.addChild(playButton)
    }
    
    func spawnPlayButtonSoftHard() {
        playButton = SKButton(imageName: "softHardPlay", buttonAction: {
                
                if playVolume == true {
                self.playSoundFX(self.tapSound)
                }
             
                self.changeToSceneBy(nameScene: "GameScene")
            })
        
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playButton.xScale = 0.1
        playButton.yScale = 0.1
        playButton.zPosition = 1
        self.addChild(playButton)
    }
 // MARK: - UINode
    func setupUI() {
        
        //LogoMenu
        let logoMenu = SKSpriteNode(imageNamed: "logoMenu")
        logoMenu.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 130)
        logoMenu.xScale = 0.3
        logoMenu.yScale = 0.3
        self.addChild(logoMenu)
        
        //Best Score Label
        let bestScoreLabelNode = LabelNode(text: "BEST SCORE", fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 400), fontColor: .textColor)
        self.addChild(bestScoreLabelNode)

    }
//MARK: - RateMeButton
    func rateMeButton() {
        
        var positionY: CGFloat!
        var positionX: CGFloat!

        if totalSize.height >= 800 {
            positionY = 130
            positionX = 240

        } else {
            positionY = 130
            positionX = 290

        }
        
         let rateMe = SKButton(imageName: "star", buttonAction: {
        
            SKStoreReviewController.requestReview()
                if playVolume == true {
                    self.playSoundFX(self.tapSound)
                }
             })
             rateMe.position = CGPoint(x: self.frame.midX + positionX, y: self.frame.midY + positionY)
             rateMe.setScale(0.16)
             rateMe.zPosition = 1
             self.addChild(rateMe)
        }
//MARK: - BestScore
    func spawnBestScore() {
        if edible == true {
             spawnBestScoreEdible()
        } else if hotCold == true {
             spawnBestScoreHotCold()
        } else if softHard == true {
             spawnBestScoreSoftHard()
        } else if carnHerb == true {
             spawnBestScoreCarnHerb()
        }
    }
    
    func spawnBestScoreEdible() {
        highScoreLabelNode = LabelNode(text: String(bestScoreEdible), fontSize: 90, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 500), fontColor: .textColor)
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreHotCold() {
        highScoreLabelNode = LabelNode(text: String(bestScoreHotCold), fontSize: 90, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 500), fontColor: .textColor)
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreSoftHard() {
        highScoreLabelNode = LabelNode(text: String(bestScoreSoftHard), fontSize: 90, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 500), fontColor: .textColor)
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreCarnHerb() {
        highScoreLabelNode = LabelNode(text: String(bestScoreCarnHarb), fontSize: 90, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 500), fontColor: .textColor)
        self.addChild(highScoreLabelNode)
    }
//MARK:- MusicOffButton
        func spawnMusicOffButton() {
            
            var positionY: CGFloat!
            var positionX: CGFloat!

            let totalSize = UIScreen.main.bounds.size
            
            if totalSize.height >= 800 {
                positionY = 240
                positionX = 240

            } else {
                positionY = 240
                positionX = 290

            }
            
             musicOffButton = SKButton(imageName: "on", buttonAction: {
            
                
                if playVolume == true {
                    self.musicOffButton.removeFromParent()
                    self.spawnMusicOnButton()
                    
                    playVolume = false
                }
                print(playVolume)
             })
            
             musicOffButton.position = CGPoint(x: self.frame.midX + positionX, y: self.frame.midY + positionY)
             musicOffButton.setScale(0.18)
             musicOffButton.zPosition = 1
             self.addChild(self.musicOffButton)
        }
    //MARK:- MusicOnButton
            func spawnMusicOnButton() {
                
                var positionY: CGFloat!
                var positionX: CGFloat!

                if totalSize.height >= 800 {
                    positionY = 240
                    positionX = 240

                } else {
                    positionY = 240
                    positionX = 290

                }
                
                 musicOnButton = SKButton(imageName: "off", buttonAction: {
                
                    
                    if playVolume == false {
                        self.musicOnButton.removeFromParent()
                        self.spawnMusicOffButton()
                        self.playSoundFX(self.tapSound)
                        playVolume = true
                    }
                    print(playVolume)
                 })
                musicOnButton.position = CGPoint(x: self.frame.midX + positionX, y: self.frame.midY + positionY)
                     musicOnButton.setScale(0.18)
                     musicOnButton.zPosition = 1
                     self.addChild(self.musicOnButton)
                }
//MARK: - CreatePanel
    func spawnButtonLevel() {
        let btnLevel = SKButton(imageName: "lvl", buttonAction: {
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
            self.createPanel()
            self.playButton.removeFromParent()
            self.highScoreLabelNode.removeFromParent()
        })
        btnLevel.position = CGPoint(x: self.frame.midX - 200, y: self.frame.midY - 100)
        btnLevel.xScale = 0.05
        btnLevel.yScale = 0.05
        btnLevel.zPosition = 1
        addChild(btnLevel)
        
    }
    
    func createPanel() {

        let panel = SKSpriteNode(imageNamed: "backgroundMini5")
        panel.zPosition = 27
        panel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        panel.name = "panel"
        panel.setScale(0.35)
        addChild(panel)
    
    //BackPanel
        let backPanel = SKButton(imageName: "close", buttonAction: {
            panel.removeFromParent()
            self.spawnPlay()
            self.spawnBestScore()
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
        })
        backPanel.setScale(0.65)
        backPanel.position = CGPoint(x: -CGFloat(600), y: CGFloat(1150))
        backPanel.zPosition = 30
        panel.addChild(backPanel)
        
    //TitleLevels
        let lvlTitle = SKLabelNode(text: "Levels")
        lvlTitle.fontName = "Helvetica"
        lvlTitle.fontSize = 180
        lvlTitle.fontColor = .black
        lvlTitle.position = CGPoint(x: CGFloat(0), y: CGFloat(1000))
        lvlTitle.zPosition = 30
        panel.addChild(lvlTitle)
        
    //edibleDefaults
        let edibleDefaults = SKButton(imageName: "play2", buttonAction: {
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
            
            UserDefaults.standard.set(true, forKey: "Edible")
            UserDefaults.standard.set(false, forKey: "HotCold")
            UserDefaults.standard.set(false, forKey: "SoftHard")
            UserDefaults.standard.set(false, forKey: "CarnHerb")
            
            panel.removeFromParent()
            self.spawnPlayButtonEdible()
            self.spawnBestScoreEdible()
        })
        edibleDefaults.setScale(0.25)
        edibleDefaults.position = CGPoint(x: -CGFloat(350), y: CGFloat(600))
        edibleDefaults.zPosition = 30
        panel.addChild(edibleDefaults)
        
    //hotColdDefaults
        let hotColdDefaults = SKButton(imageName: "hotColdPlay", buttonAction: {
            
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
            if self.bestScoreEdible >= 25 {
                UserDefaults.standard.set(false, forKey: "Edible")
                UserDefaults.standard.set(true, forKey: "HotCold")
                UserDefaults.standard.set(false, forKey: "SoftHard")
                UserDefaults.standard.set(false, forKey: "CarnHerb")
                
                panel.removeFromParent()
                self.spawnPlayButtonHotCold()
                self.spawnBestScoreHotCold()
            } else {
                print("HotCold-Lock")
            }
            
        })
        hotColdDefaults.setScale(0.25)
        hotColdDefaults.position = CGPoint(x: CGFloat(350), y: CGFloat(600))
        hotColdDefaults.zPosition = 30
        panel.addChild(hotColdDefaults)
        
    //hardSoftDefaults
        let hardSoftDefaults = SKButton(imageName: "softHardPlay", buttonAction: {
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
            
            if self.bestScoreHotCold >= 50 {
                UserDefaults.standard.set(false, forKey: "Edible")
                UserDefaults.standard.set(false, forKey: "HotCold")
                UserDefaults.standard.set(true, forKey: "SoftHard")
                UserDefaults.standard.set(false, forKey: "CarnHerb")
                
                panel.removeFromParent()
                self.spawnPlayButtonSoftHard()
                self.spawnBestScoreSoftHard()
            } else {
                print("SoftHard-Lock")
            }
            
        })
        hardSoftDefaults.setScale(0.25)
        hardSoftDefaults.position = CGPoint(x: -CGFloat(350), y: -CGFloat(200))
        hardSoftDefaults.zPosition = 30
        panel.addChild(hardSoftDefaults)
        
    //carbHerdDefaults
        let carbHerdDefaults = SKButton(imageName: "grassMeatPlay", buttonAction: {
            if playVolume == true {
                self.playSoundFX(self.tapSound)
            }
            
            if self.bestScoreSoftHard >= 75 {
                UserDefaults.standard.set(false, forKey: "Edible")
                UserDefaults.standard.set(false, forKey: "HotCold")
                UserDefaults.standard.set(false, forKey: "SoftHard")
                UserDefaults.standard.set(true, forKey: "CarnHerb")
                
                panel.removeFromParent()
                self.spawnPlayButtonCarnHerb()
                self.spawnBestScoreCarnHerb()
            } else {
                print("HerbCarn-lock")
            }
            
        })
        carbHerdDefaults.setScale(0.25)
        carbHerdDefaults.position = CGPoint(x: CGFloat(350), y: -CGFloat(200))
        carbHerdDefaults.zPosition = 30
        panel.addChild(carbHerdDefaults)
        
        //Title
        let edibleTitle = SKLabelNode(text: "Edible/Not Edible")
        edibleTitle.fontName = "Helvetica"
        edibleTitle.fontSize = 80
        edibleTitle.fontColor = .black
        edibleTitle.position = CGPoint(x: -CGFloat(350), y: CGFloat(200))
        edibleTitle.zPosition = 30
        panel.addChild(edibleTitle)
        
        let hotColdTitle = SKLabelNode(text: "Hot/Cold")
        hotColdTitle.fontName = "Helvetica"
        hotColdTitle.fontSize = 80
        hotColdTitle.fontColor = .black
        hotColdTitle.position = CGPoint(x: CGFloat(350), y: CGFloat(200))
        hotColdTitle.zPosition = 30
        panel.addChild(hotColdTitle)
        
        let softHardTitle = SKLabelNode(text: "Soft/Hard")
        softHardTitle.fontName = "Helvetica"
        softHardTitle.fontSize = 80
        softHardTitle.fontColor = .black
        softHardTitle.position = CGPoint(x: -CGFloat(350), y: -CGFloat(600))
        softHardTitle.zPosition = 30
        panel.addChild(softHardTitle)
        
        let grassMeatTitle = SKLabelNode(text: "Herbivore/Carnivore")
        grassMeatTitle.fontName = "Helvetica"
        grassMeatTitle.fontSize = 80
        grassMeatTitle.fontColor = .black
        grassMeatTitle.position = CGPoint(x: CGFloat(350), y: -CGFloat(600))
        grassMeatTitle.zPosition = 30
        panel.addChild(grassMeatTitle)
        
    //Lock
        if bestScoreEdible <= 24 {
            let lockHotCold = SKSpriteNode(imageNamed: "lock")
            lockHotCold.setScale(1.0)
            lockHotCold.position = CGPoint(x: CGFloat(550), y: CGFloat(400))
            lockHotCold.zPosition = 31
            lockHotCold.zRotation = 7.2
            panel.addChild(lockHotCold)
            let lockHotColdTitleNumber = SKLabelNode(text: "25")
            lockHotColdTitleNumber.fontSize = 180
            lockHotColdTitleNumber.fontColor = .black
            lockHotColdTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockHotColdTitleNumber.zPosition = 31
            lockHotCold.addChild(lockHotColdTitleNumber)
            let lockHotColdTitle = SKLabelNode(text: "Edible/")
            lockHotColdTitle.fontSize = 80
            lockHotColdTitle.fontColor = .black
            lockHotColdTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(150))
            lockHotColdTitle.zPosition = 31
            lockHotCold.addChild(lockHotColdTitle)
            let lockHotColdTitle2 = SKLabelNode(text: "NotEdible")
            lockHotColdTitle2.fontSize = 80
            lockHotColdTitle2.fontColor = .black
            lockHotColdTitle2.position = CGPoint(x: CGFloat(0), y: -CGFloat(230))
            lockHotColdTitle2.zPosition = 31
            lockHotCold.addChild(lockHotColdTitle2)
        }
        if bestScoreHotCold <= 49 {
            let lockSoftHard = SKSpriteNode(imageNamed: "lock")
            lockSoftHard.setScale(1.0)
            lockSoftHard.position = CGPoint(x: -CGFloat(550), y: -CGFloat(400))
            lockSoftHard.zPosition = 31
            lockSoftHard.zRotation = -7.4
            panel.addChild(lockSoftHard)
            let lockSoftHardTitleNumber = SKLabelNode(text: "50")
            lockSoftHardTitleNumber.fontSize = 180
            lockSoftHardTitleNumber.fontColor = .black
            lockSoftHardTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockSoftHardTitleNumber.zPosition = 31
            lockSoftHard.addChild(lockSoftHardTitleNumber)
            let lockSoftHardTitle = SKLabelNode(text: "Hot/Cold")
            lockSoftHardTitle.fontSize = 100
            lockSoftHardTitle.fontColor = .black
            lockSoftHardTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(200))
            lockSoftHardTitle.zPosition = 31
            lockSoftHard.addChild(lockSoftHardTitle)
        }
        
        if bestScoreSoftHard <= 74 {
            let lockCarnHerb = SKSpriteNode(imageNamed: "lock")
            lockCarnHerb.setScale(1.0)
            lockCarnHerb.position = CGPoint(x: CGFloat(550), y: -CGFloat(400))
            lockCarnHerb.zPosition = 31
            lockCarnHerb.zRotation = 7.3
            panel.addChild(lockCarnHerb)
            let lockCarnHerbTitleNumber = SKLabelNode(text: "75")
            lockCarnHerbTitleNumber.fontSize = 180
            lockCarnHerbTitleNumber.fontColor = .black
            lockCarnHerbTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockCarnHerbTitleNumber.zPosition = 31
            lockCarnHerb.addChild(lockCarnHerbTitleNumber)
            let lockCarnHerbTitle = SKLabelNode(text: "Soft/Hard")
            lockCarnHerbTitle.fontSize = 95
            lockCarnHerbTitle.fontColor = .black
            lockCarnHerbTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(200))
            lockCarnHerbTitle.zPosition = 31
            lockCarnHerb.addChild(lockCarnHerbTitle)
        }
        
    }
}
