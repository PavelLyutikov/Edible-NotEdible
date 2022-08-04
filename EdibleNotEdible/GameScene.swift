//
//  GameScene.swift
//  EdibleNotEdible
//
//  Created by mac on 18.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit

var fail: Int = 0

class GameScene: SimpleScene {

    var score: Int = 0
    var timer: Timer?
    var initialSeconds: TimeInterval = 15
    
    let bestScoreEdible = UserDefaults.standard.integer(forKey: "bestScoreEdible")
    let bestScoreHotCold = UserDefaults.standard.integer(forKey: "bestScoreHotCold")
    let bestScoreSoftHard = UserDefaults.standard.integer(forKey: "bestScoreSoftHard")
    let bestScoreCarnHarb = UserDefaults.standard.integer(forKey: "bestScoreCarnHarb")
    
    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    var panel: SKSpriteNode!
    var back: SKSpriteNode!
    
    private var viewModel: GameSceneViewModel = GameSceneViewModel()
    var objectNode: SKSpriteNode!
    var tapEdible: SKButton!
    var tapNotEdible: SKButton!
    
    var totalTrueLabelNode = SKLabelNode()
    var scoreLabelNode = SKLabelNode()
    var tutotialNode = SKSpriteNode()
    var timeLabelNode = SKLabelNode()
    var adCount: Int = 0
    
    var openPanel: Bool = false
    var oneShowAds: Bool = false
    var timesUp: Bool = false
    
    override func didMove(to view: SKView) {
        
        if playVolume == true {
            playBackgroundMusic(fileName: "clockSound.mp3")
        }
        
        self.viewModel.updateTimeLabel = {
            self.updateTimeLabel()
        }
        
        //SuccessfulShowRewardVideo
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.successfulAdViewing), name: NSNotification.Name(rawValue: "successfulAdViewing"), object: nil)
        
        backgroundColor = #colorLiteral(red: 0, green: 0.5459641814, blue: 0.8740547299, alpha: 1)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.setupTimer()
        }
        
        self.setupUINodes()

    }
    
    func gameOver() {
        if self.openPanel == false && self.oneShowAds == false {
        self.timesUp = true
            
        self.spawnPanelGameOver()
        self.changeScore(add: true)
            
            if playVolume == true {
                self.run(Sound.timeIsUp.action)
                backgroungMusicPlayer.stop()
            }
        }
        
        if self.oneShowAds == true {
            self.openPanel = false

            self.saveScore(svScore: true)
                            
            self.failScore()
            self.failedTimeToSceneBy(nameScene: "FailedTimeScene")
        }
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
        timeLabelNode = LabelNode(text: String(format: "%.1f", initialSeconds), fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 225), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        timeLabelNode.zPosition = 1
        timeLabelNode.fontName = "Chalkboard SE"
        self.addChild(timeLabelNode)
        
        // True Label Node
        scoreLabelNode = LabelNode(text: "\(score)", fontSize: 140, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 300), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        scoreLabelNode.zPosition = -1
        scoreLabelNode.fontName = "Chalkboard SE"
        self.addChild(scoreLabelNode)
        
        // Total True Label Node
        switch Locale.current.languageCode {
        case "ru":
            totalTrueLabelNode = LabelNode(text: "СЧЁТ:", fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 160), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            totalTrueLabelNode.zPosition = -1
            totalTrueLabelNode.fontName = "Chalkboard SE"
            self.addChild(totalTrueLabelNode)
        default:
            totalTrueLabelNode = LabelNode(text: "SCORE:", fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 160), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            totalTrueLabelNode.zPosition = -1
            totalTrueLabelNode.fontName = "Chalkboard SE"
            self.addChild(totalTrueLabelNode)
        }
        
        
        var tapEdibleImage: String!
        var tapNotEdibleImage: String!
        var tapSoftImage: String!
        var tapHardImage: String!
        var tapHotImage: String!
        var tapColdImage: String!
        var tapCarnivoreImage: String!
        var tapHerbivoreImage: String!
        switch Locale.current.languageCode {
        case "ru":
            tapEdibleImage = "tapEdibleRus"
            tapNotEdibleImage = "tapNotEdibleRus"
            tapSoftImage = "tapSoftRus"
            tapHardImage = "tapHardRus"
            tapHotImage = "tapHotRus"
            tapColdImage = "tapColdRus"
            tapCarnivoreImage = "tapCarnivoreRus"
            tapHerbivoreImage = "tapHerbivoreRus"
        default:
            tapEdibleImage = "tapEdible"
            tapNotEdibleImage = "tapNotEdible"
            tapSoftImage = "tapSoft"
            tapHardImage = "tapHard"
            tapHotImage = "tapHot"
            tapColdImage = "tapCold"
            tapCarnivoreImage = "tapCarnivore"
            tapHerbivoreImage = "tapHerbivore"
        }
        
        //TapEdible
        if edible == true {
            tapEdible = SKButton(imageName: tapEdibleImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                        }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                        
                                                self.timer?.invalidate()
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                })
        } else if softHard == true {
            tapEdible = SKButton(imageName: tapSoftImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                        }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                })
        } else if hotCold == true {
            tapEdible = SKButton(imageName: tapHotImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                        }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                })
        } else if carnHerb == true {
            tapEdible = SKButton(imageName: tapHerbivoreImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true{
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                        }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
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
            tapNotEdible = SKButton(imageName: tapNotEdibleImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                            }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                
                                                self.timer?.invalidate()
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if softHard == true {
            tapNotEdible = SKButton(imageName: tapHardImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                            }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if hotCold == true {
            tapNotEdible = SKButton(imageName: tapColdImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                            }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                    
                                })
        } else if carnHerb == true {
            tapNotEdible = SKButton(imageName: tapCarnivoreImage, buttonAction: {
                                    guard self.viewModel.currentNode != nil else {return}
                                    if !self.viewModel.currentNode!.isEdible {
                                        if playVolume == true {
                                            self.run(Sound.win.action)
                                        }
                                        self.createNewObject()
                                        self.changeScore(add: true)
                                        self.updateLabel()
                                    } else {
                                        self.changeScore(add: false) {
                                            if playVolume == true {
                                            backgroungMusicPlayer.stop()
                                                self.run(Sound.fail.action)
                                            }
                                            if self.oneShowAds == false {
                                                self.spawnPanelGameOver()
                                            } else {
                                                self.openPanel = false
                
                                                self.saveScore(svScore: true)
                                                                
                                                self.failScore()
                                                self.failedToSceneBy(nameScene: "FailedScene")
                                                
                                            }
                                        }
                                        self.updateLabel()
                                    }
                                    
                                })
        }
            
        
            tapNotEdible.position = CGPoint(x: self.frame.midX + 140, y: self.frame.minY + 250)
            tapNotEdible.xScale = 0.1
            tapNotEdible.yScale = 0.1
            
            tapNotEdible.zPosition = 1
            self.addChild(tapNotEdible)
    
        createNewObject()
    }

//MARK: - GameOverPanel
    
    func spawnPanelGameOver() {
        
        openPanel = true
        
        timer?.invalidate()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.scene?.view?.isPaused = true
        }
        
        panel = SKSpriteNode(imageNamed: "backgroundMini2")
        panel.setScale(0.38)
        panel.position = CGPoint(x: self.frame.midX + 3, y: self.frame.midY)
        panel.zPosition = 5
        addChild(panel)
        
        back = SKSpriteNode(imageNamed: "backgroundMini5")
        back.setScale(1)
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        back.zPosition = 3
        back.alpha = 0.1
        addChild(back)
        
        
        switch Locale.current.languageCode {
        case "ru":
            let showAds = SKButton(imageName: "showAds", buttonAction: {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showRewardVideo"), object: nil)
            })
            showAds.setScale(2.5)
            showAds.position = CGPoint(x: 0, y: -200)
            showAds.zPosition = 6
            panel.addChild(showAds)
        default:
            let showAds = SKButton(imageName: "showAdsEng", buttonAction: {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showRewardVideo"), object: nil)
            })
            showAds.setScale(2.5)
            showAds.position = CGPoint(x: 0, y: -200)
            showAds.zPosition = 6
            panel.addChild(showAds)
        }
        
        
        let close = SKButton(imageName: "close", buttonAction: {
            self.scene?.view?.isPaused = false
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            
                if playVolume == true {
                    self.run(Sound.tap.action)
                }
                
                self.openPanel = false
                self.saveScore(svScore: true)
                self.failScore()
                
                
                if self.timesUp == true {
                    self.failedTimeToSceneBy(nameScene: "FailedTimeScene")
                } else {
                    self.failedToSceneBy(nameScene: "FailedScene")
                }
            }
        })
        close.setScale(0.60)
        close.position = CGPoint(x: 660, y: 460)
        close.zPosition = 6
        panel.addChild(close)
        
        if timesUp == true {
            switch Locale.current.languageCode {
            case "ru":
                let label = SKLabelNode(fontNamed: "Chalkboard SE")
                label.text = "Время!!"
                label.position = CGPoint(x: 0, y: 200)
                label.fontColor = .white
                label.fontSize = 240
                label.zPosition = 6
                panel.addChild(label)
            default:
                let label = SKLabelNode(fontNamed: "Chalkboard SE")
                label.text = "Time!!"
                label.position = CGPoint(x: 0, y: 200)
                label.fontColor = .white
                label.fontSize = 240
                label.zPosition = 6
                panel.addChild(label)
            }
        } else {
            switch Locale.current.languageCode {
            case "ru":
                let label = SKLabelNode(fontNamed: "Chalkboard SE")
                label.text = "Неверно!!"
                label.position = CGPoint(x: 0, y: 200)
                label.fontColor = .white
                label.fontSize = 240
                label.zPosition = 6
                panel.addChild(label)
            default:
                let label = SKLabelNode(fontNamed: "Chalkboard SE")
                label.text = "Mistake!!"
                label.position = CGPoint(x: 0, y: 200)
                label.fontColor = .white
                label.fontSize = 240
                label.zPosition = 6
                panel.addChild(label)
            }
        }
    }
//MARK: - SuccessfulAdViewing
    @objc func successfulAdViewing() {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
        if playVolume == true {
         playBackgroundMusic(fileName: "clock.mp3")
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            
            self.setupTimerTwo()
            
            self.scene?.view?.isPaused = false

            guard self.viewModel.currentNode != nil else {return}
            self.changeScore(add: true)
            self.createNewObject()
            self.updateTimeLabel()
            
            self.openPanel = false
            self.oneShowAds = true
            
                self.panel.removeFromParent()
                self.back.removeFromParent()
            }
        }
        
    }
//MARK: - NewScore
    
    @objc func timerAction() {
            
        initialSeconds -= 0.1
        print(initialSeconds)
        
        if initialSeconds <= 0 {
            
            initialSeconds = 0.0
            timer?.invalidate()
            
            gameOver()
        }
        updateTimeLabel()
        
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    func setupTimerTwo() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func changeScore(add: Bool, completion: @escaping (() -> Void) = {}) {
            if add {
                score += 1
                
                if score >= 50 {
                    initialSeconds = 1
                } else if score >= 25 {
                    initialSeconds = 2
                } else if score >= 20 {
                    initialSeconds = 3
                } else if score >= 15 {
                    initialSeconds = 4
                } else if score >= 10 {
                    initialSeconds = 5
                } else if score >= 5 {
                    initialSeconds = 6
                } else if score >= 1 {
                    initialSeconds = 10
                } else {
                    initialSeconds = 15
    }
            } else {
                
//                self.timer?.invalidate()
                completion()
            }
        }
    func saveScore(svScore: Bool, completion: @escaping (() -> Void) = {}) {
            if svScore {
                setScore()
                setBestScore()
            }
        }
    
    // Вывод BestScore если побил рекорд
    func setBestScore() {
        if edible == true {
            if bestScoreEdible < score {
                UserDefaults.standard.set(score, forKey: "bestScoreEdible")
                UserDefaults.standard.synchronize()
            }
        } else if hotCold == true {
            if bestScoreHotCold < score {
                UserDefaults.standard.set(score, forKey: "bestScoreHotCold")
                UserDefaults.standard.synchronize()
            }
        } else if softHard == true {
            if bestScoreSoftHard < score {
                UserDefaults.standard.set(score, forKey: "bestScoreSoftHard")
                UserDefaults.standard.synchronize()
            }
        } else if carnHerb == true {
            if bestScoreCarnHarb < score {
                UserDefaults.standard.set(score, forKey: "bestScoreCarnHarb")
                UserDefaults.standard.synchronize()
            }
        }
        
    }
    func setScore() {
        if score >= 0 {
            UserDefaults.standard.set(score, forKey: "failedScore")
            UserDefaults.standard.synchronize()
        }
    }
    
    func updateLabel() {
        if scoreLabelNode.parent != nil {
            self.scoreLabelNode.removeFromParent()
            self.scoreLabelNode = LabelNode(text: "\(score)", fontSize: 140, position: CGPoint(x: self.frame.midX, y: self.frame.midY - 300), fontColor: .textColor)
            self.zPosition = -1
            self.addChild(scoreLabelNode)
        }
        self.update(0)
    }
    
    func updateTimeLabel() {
        if timeLabelNode.parent != nil {
            self.timeLabelNode.removeFromParent()
            self.timeLabelNode = LabelNode(text: String(format: "%.1f", initialSeconds), fontSize: 60, position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 225), fontColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
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
        oneShowAds = false
        
        if fail >= 4 {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentInterstitial"), object: nil)
            fail = 0
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
