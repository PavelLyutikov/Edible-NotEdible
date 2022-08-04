//
//  MenuScene.swift
//  EdibleNotEdible
//
//  Created by mac on 20.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit
import StoreKit

class MenuScene: SimpleScene {
    
    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    let bestScoreEdible = UserDefaults.standard.integer(forKey: "bestScoreEdible")
    let bestScoreHotCold = UserDefaults.standard.integer(forKey: "bestScoreHotCold")
    let bestScoreSoftHard = UserDefaults.standard.integer(forKey: "bestScoreSoftHard")
    let bestScoreCarnHarb = UserDefaults.standard.integer(forKey: "bestScoreCarnHarb")
    
    let highScoreLabelNode = SKLabelNode(fontNamed: "Chalkboard SE")
    let totalSize = UIScreen.main.bounds.size
    
    var backgroundTexture: SKTexture!
    var background = SKSpriteNode()
    var backgroundObject = SKNode()
    var playButton: SKButton!
    
    var musicOffButton: SKButton!
    var musicOnButton: SKButton!

//MARK: - DidMove
    override func didMove(to view: SKView) {
        backgroundTexture = SKTexture(imageNamed: "background")
        self.backgroundColor = .defBackground
        
//        UserDefaults.standard.set(55, forKey: "bestScoreEdible")
//        UserDefaults.standard.set(73, forKey: "bestScoreHotCold")
//        UserDefaults.standard.set(81, forKey: "bestScoreSoftHard")
        
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
                        self.run(Sound.tap.action)
                    }

                    self.changeToSceneBy(nameScene: "GameScene")
                
                    gameSceneClosed = false
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
                    self.run(Sound.tap.action)
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
                    self.run(Sound.tap.action)
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
                    self.run(Sound.tap.action)
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
        switch Locale.current.languageCode {
        case "ru":
            let logoMenu = SKSpriteNode(imageNamed: "logoMenuRus2")
            logoMenu.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 130)
            logoMenu.xScale = 0.3
            logoMenu.yScale = 0.3
            self.addChild(logoMenu)
        default:
            let logoMenu = SKSpriteNode(imageNamed: "logoMenu")
            logoMenu.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 130)
            logoMenu.xScale = 0.3
            logoMenu.yScale = 0.3
            self.addChild(logoMenu)
        }
        
        //Best Score Label
        switch Locale.current.languageCode {
        case "ru":
            let bestScoreLabelNode = SKLabelNode(fontNamed: "Chalkboard SE")
            bestScoreLabelNode.text = "ЛУЧШИЙ РЕЗУЛЬТАТ"
            bestScoreLabelNode.position =  CGPoint(x: self.frame.midX, y: self.frame.midY - 400)
            bestScoreLabelNode.fontColor = .textColor
            bestScoreLabelNode.zPosition = 2
            bestScoreLabelNode.fontSize = 60
            self.addChild(bestScoreLabelNode)
        default:
            let bestScoreLabelNode = SKLabelNode(fontNamed: "Chalkboard SE")
            bestScoreLabelNode.text = "BEST SCORE"
            bestScoreLabelNode.position =  CGPoint(x: self.frame.midX, y: self.frame.midY - 400)
            bestScoreLabelNode.fontColor = .textColor
            bestScoreLabelNode.zPosition = 2
            bestScoreLabelNode.fontSize = 70
            self.addChild(bestScoreLabelNode)
        }
        

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
                    self.run(Sound.tap.action)
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
        highScoreLabelNode.zPosition = 2
        highScoreLabelNode.text = String(bestScoreEdible)
        highScoreLabelNode.fontSize = 90
        highScoreLabelNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 500)
        highScoreLabelNode.fontColor = .textColor
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreHotCold() {
        highScoreLabelNode.zPosition = 2
        highScoreLabelNode.text = String(bestScoreHotCold)
        highScoreLabelNode.fontSize = 90
        highScoreLabelNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 500)
        highScoreLabelNode.fontColor = .textColor
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreSoftHard() {
        highScoreLabelNode.zPosition = 2
        highScoreLabelNode.text = String(bestScoreSoftHard)
        highScoreLabelNode.fontSize = 90
        highScoreLabelNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 500)
        highScoreLabelNode.fontColor = .textColor
        self.addChild(highScoreLabelNode)
    }
    func spawnBestScoreCarnHerb() {
        highScoreLabelNode.zPosition = 2
        highScoreLabelNode.text = String(bestScoreCarnHarb)
        highScoreLabelNode.fontSize = 90
        highScoreLabelNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 500)
        highScoreLabelNode.fontColor = .textColor
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
                        self.run(Sound.tap.action)
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
                self.run(Sound.tap.action)
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
                self.run(Sound.tap.action)
            }
        })
        backPanel.setScale(0.65)
        backPanel.position = CGPoint(x: -CGFloat(600), y: CGFloat(1150))
        backPanel.zPosition = 30
        panel.addChild(backPanel)
        
    //TitleLevels
        switch Locale.current.languageCode {
        case "ru":
            let lvlTitle = SKLabelNode(text: "Уровни")
            lvlTitle.fontName = "Chalkboard SE"
            lvlTitle.fontSize = 190
            lvlTitle.fontColor = .black
            lvlTitle.position = CGPoint(x: CGFloat(0), y: CGFloat(1000))
            lvlTitle.zPosition = 30
            panel.addChild(lvlTitle)
        default:
            let lvlTitle = SKLabelNode(text: "Levels")
            lvlTitle.fontName = "Chalkboard SE"
            lvlTitle.fontSize = 180
            lvlTitle.fontColor = .black
            lvlTitle.position = CGPoint(x: CGFloat(0), y: CGFloat(1000))
            lvlTitle.zPosition = 30
            panel.addChild(lvlTitle)
        }
        
    //edibleDefaults
        let edibleDefaults = SKButton(imageName: "play2", buttonAction: {
            if playVolume == true {
                self.run(Sound.tap.action)
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
                self.run(Sound.tap.action)
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
                self.run(Sound.tap.action)
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
                self.run(Sound.tap.action)
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
        switch Locale.current.languageCode {
        case "ru":
            let edibleTitle = SKLabelNode(text: "Съедобное/НеСъедобное")
            edibleTitle.fontName = "Chalkboard SE"
            edibleTitle.fontSize = 80
            edibleTitle.fontColor = .black
            edibleTitle.numberOfLines = 2
            edibleTitle.preferredMaxLayoutWidth = 540
            edibleTitle.position = CGPoint(x: -CGFloat(350), y: CGFloat(130))
            edibleTitle.zPosition = 30
            panel.addChild(edibleTitle)
        default:
            let edibleTitle = SKLabelNode(text: "Edible/Not Edible")
            edibleTitle.fontName = "Chalkboard SE"
            edibleTitle.fontSize = 80
            edibleTitle.fontColor = .black
            edibleTitle.position = CGPoint(x: -CGFloat(350), y: CGFloat(200))
            edibleTitle.zPosition = 30
            panel.addChild(edibleTitle)
        }
        
        switch Locale.current.languageCode {
        case "ru":
            let hotColdTitle = SKLabelNode(text: "Горячее/Холодное")
            hotColdTitle.fontName = "Chalkboard SE"
            hotColdTitle.fontSize = 80
            hotColdTitle.fontColor = .black
            hotColdTitle.numberOfLines = 2
            hotColdTitle.preferredMaxLayoutWidth = 540
            hotColdTitle.position = CGPoint(x: CGFloat(350), y: CGFloat(130))
            hotColdTitle.zPosition = 30
            panel.addChild(hotColdTitle)
        default:
            let hotColdTitle = SKLabelNode(text: "Hot/Cold")
            hotColdTitle.fontName = "Chalkboard SE"
            hotColdTitle.fontSize = 80
            hotColdTitle.fontColor = .black
            hotColdTitle.position = CGPoint(x: CGFloat(350), y: CGFloat(200))
            hotColdTitle.zPosition = 30
            panel.addChild(hotColdTitle)
        }
        
        switch Locale.current.languageCode {
        case "ru":
            let softHardTitle = SKLabelNode(text: "Мягкое/Твердое")
            softHardTitle.fontName = "Chalkboard SE"
            softHardTitle.fontSize = 80
            softHardTitle.fontColor = .black
            softHardTitle.numberOfLines = 2
            softHardTitle.preferredMaxLayoutWidth = 540
            softHardTitle.position = CGPoint(x: -CGFloat(350), y: -CGFloat(670))
            softHardTitle.zPosition = 30
            panel.addChild(softHardTitle)
        default:
            let softHardTitle = SKLabelNode(text: "Soft/Hard")
            softHardTitle.fontName = "Chalkboard SE"
            softHardTitle.fontSize = 80
            softHardTitle.fontColor = .black
            softHardTitle.position = CGPoint(x: -CGFloat(350), y: -CGFloat(600))
            softHardTitle.zPosition = 30
            panel.addChild(softHardTitle)
        }
        
        switch Locale.current.languageCode {
        case "ru":
            let grassMeatTitle = SKLabelNode(text: "Травоядное/Плотоядное")
            grassMeatTitle.fontName = "Chalkboard SE"
            grassMeatTitle.fontSize = 80
            grassMeatTitle.fontColor = .black
            grassMeatTitle.numberOfLines = 2
            grassMeatTitle.preferredMaxLayoutWidth = 540
            grassMeatTitle.position = CGPoint(x: CGFloat(350), y: -CGFloat(670))
            grassMeatTitle.zPosition = 30
            panel.addChild(grassMeatTitle)
        default:
            let grassMeatTitle = SKLabelNode(text: "Herbivore/Carnivore")
            grassMeatTitle.fontName = "Chalkboard SE"
            grassMeatTitle.fontSize = 80
            grassMeatTitle.fontColor = .black
            grassMeatTitle.position = CGPoint(x: CGFloat(350), y: -CGFloat(600))
            grassMeatTitle.zPosition = 30
            panel.addChild(grassMeatTitle)
        }
        
    //Lock
        if bestScoreEdible <= 24 {
            let lockHotCold = SKSpriteNode(imageNamed: "lock")
            lockHotCold.setScale(1.0)
            lockHotCold.position = CGPoint(x: CGFloat(550), y: CGFloat(400))
            lockHotCold.zPosition = 31
            lockHotCold.zRotation = 7.2
            panel.addChild(lockHotCold)
            let lockHotColdTitleNumber = SKLabelNode(fontNamed: "Chalkboard SE")
            lockHotColdTitleNumber.text = "25"
            lockHotColdTitleNumber.fontSize = 180
            lockHotColdTitleNumber.fontColor = .black
            lockHotColdTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockHotColdTitleNumber.zPosition = 31
            lockHotCold.addChild(lockHotColdTitleNumber)
            switch Locale.current.languageCode {
            case "ru":
                let lockHotColdTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockHotColdTitle.text = "Съедобное/"
                lockHotColdTitle.fontSize = 60
                lockHotColdTitle.fontColor = .black
                lockHotColdTitle.numberOfLines = 2
                lockHotColdTitle.preferredMaxLayoutWidth = 500
                lockHotColdTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(170))
                lockHotColdTitle.zPosition = 31
                lockHotCold.addChild(lockHotColdTitle)
                let lockHotColdTitle2 = SKLabelNode(fontNamed: "Chalkboard SE")
                lockHotColdTitle2.text = "НеСъедобное"
                lockHotColdTitle2.fontSize = 60
                lockHotColdTitle2.fontColor = .black
                lockHotColdTitle2.numberOfLines = 2
                lockHotColdTitle2.preferredMaxLayoutWidth = 500
                lockHotColdTitle2.position = CGPoint(x: CGFloat(0), y: -CGFloat(240))
                lockHotColdTitle2.zPosition = 31
                lockHotCold.addChild(lockHotColdTitle2)
            default:
                let lockHotColdTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockHotColdTitle.text = "Edible/"
                lockHotColdTitle.fontSize = 80
                lockHotColdTitle.fontColor = .black
                lockHotColdTitle.numberOfLines = 2
                lockHotColdTitle.preferredMaxLayoutWidth = 500
                lockHotColdTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(180))
                lockHotColdTitle.zPosition = 31
                lockHotCold.addChild(lockHotColdTitle)
                let lockHotColdTitle2 = SKLabelNode(fontNamed: "Chalkboard SE")
                lockHotColdTitle2.text = "NotEdible"
                lockHotColdTitle2.fontSize = 80
                lockHotColdTitle2.fontColor = .black
                lockHotColdTitle2.numberOfLines = 2
                lockHotColdTitle2.preferredMaxLayoutWidth = 500
                lockHotColdTitle2.position = CGPoint(x: CGFloat(0), y: -CGFloat(260))
                lockHotColdTitle2.zPosition = 31
                lockHotCold.addChild(lockHotColdTitle2)
            }
        }
        if bestScoreHotCold <= 49 {
            let lockSoftHard = SKSpriteNode(imageNamed: "lock")
            lockSoftHard.setScale(1.0)
            lockSoftHard.position = CGPoint(x: -CGFloat(550), y: -CGFloat(400))
            lockSoftHard.zPosition = 31
            lockSoftHard.zRotation = -7.4
            panel.addChild(lockSoftHard)
            let lockSoftHardTitleNumber = SKLabelNode(fontNamed: "Chalkboard SE")
            lockSoftHardTitleNumber.text = "50"
            lockSoftHardTitleNumber.fontSize = 180
            lockSoftHardTitleNumber.fontColor = .black
            lockSoftHardTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockSoftHardTitleNumber.zPosition = 31
            lockSoftHard.addChild(lockSoftHardTitleNumber)
            switch Locale.current.languageCode {
            case "ru":
                let lockSoftHardTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockSoftHardTitle.text = "Горячее/"
                lockSoftHardTitle.fontSize = 75
                lockSoftHardTitle.fontColor = .black
                lockSoftHardTitle.numberOfLines = 2
                lockSoftHardTitle.preferredMaxLayoutWidth = 500
                lockSoftHardTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(170))
                lockSoftHardTitle.zPosition = 31
                lockSoftHard.addChild(lockSoftHardTitle)
                let lockSoftHardTitle2 = SKLabelNode(fontNamed: "Chalkboard SE")
                lockSoftHardTitle2.text = "Холодное"
                lockSoftHardTitle2.fontSize = 80
                lockSoftHardTitle2.fontColor = .black
                lockSoftHardTitle2.numberOfLines = 2
                lockSoftHardTitle2.preferredMaxLayoutWidth = 500
                lockSoftHardTitle2.position = CGPoint(x: CGFloat(0), y: -CGFloat(250))
                lockSoftHardTitle2.zPosition = 31
                lockSoftHard.addChild(lockSoftHardTitle2)
            default:
                let lockSoftHardTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockSoftHardTitle.text = "Hot/Cold"
                lockSoftHardTitle.fontSize = 90
                lockSoftHardTitle.fontColor = .black
                lockSoftHardTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(200))
                lockSoftHardTitle.zPosition = 31
                lockSoftHard.addChild(lockSoftHardTitle)
            }
        }
        
        if bestScoreSoftHard <= 74 {
            let lockCarnHerb = SKSpriteNode(imageNamed: "lock")
            lockCarnHerb.setScale(1.0)
            lockCarnHerb.position = CGPoint(x: CGFloat(550), y: -CGFloat(400))
            lockCarnHerb.zPosition = 31
            lockCarnHerb.zRotation = 7.3
            panel.addChild(lockCarnHerb)
            let lockCarnHerbTitleNumber = SKLabelNode(fontNamed: "Chalkboard SE")
            lockCarnHerbTitleNumber.text = "75"
            lockCarnHerbTitleNumber.fontSize = 180
            lockCarnHerbTitleNumber.fontColor = .black
            lockCarnHerbTitleNumber.position = CGPoint(x: CGFloat(0), y: -CGFloat(80))
            lockCarnHerbTitleNumber.zPosition = 31
            lockCarnHerb.addChild(lockCarnHerbTitleNumber)
            switch Locale.current.languageCode {
            case "ru":
                let lockCarnHerbTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockCarnHerbTitle.text = "Мягкое/"
                lockCarnHerbTitle.fontSize = 75
                lockCarnHerbTitle.fontColor = .black
                lockCarnHerbTitle.numberOfLines = 2
                lockCarnHerbTitle.preferredMaxLayoutWidth = 500
                lockCarnHerbTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(170))
                lockCarnHerbTitle.zPosition = 31
                lockCarnHerb.addChild(lockCarnHerbTitle)
                let lockCarnHerbTitle2 = SKLabelNode(fontNamed: "Chalkboard SE")
                lockCarnHerbTitle2.text = "Твердое"
                lockCarnHerbTitle2.fontSize = 80
                lockCarnHerbTitle2.fontColor = .black
                lockCarnHerbTitle2.numberOfLines = 2
                lockCarnHerbTitle2.preferredMaxLayoutWidth = 500
                lockCarnHerbTitle2.position = CGPoint(x: CGFloat(0), y: -CGFloat(250))
                lockCarnHerbTitle2.zPosition = 31
                lockCarnHerb.addChild(lockCarnHerbTitle2)
            default:
                let lockCarnHerbTitle = SKLabelNode(fontNamed: "Chalkboard SE")
                lockCarnHerbTitle.text = "Soft/Hard"
                lockCarnHerbTitle.fontSize = 85
                lockCarnHerbTitle.fontColor = .black
                lockCarnHerbTitle.position = CGPoint(x: CGFloat(0), y: -CGFloat(200))
                lockCarnHerbTitle.zPosition = 31
                lockCarnHerb.addChild(lockCarnHerbTitle)
            }
        }
        
    }
    
}
