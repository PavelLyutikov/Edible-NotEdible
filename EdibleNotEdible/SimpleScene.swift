//
//  SimpleScene.swift
//  EdibleNotEdible
//
//  Created by mac on 20.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit

class SimpleScene : SKScene {
    
//MARK: - Edible
    func changeToSceneBy(nameScene: String) {
        let scene = (nameScene == "GameScene") ? GameScene(size: self.size) : MenuScene(size: self.size)
        
        let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
        
        scene.scaleMode = .aspectFill

        self.view?.presentScene(scene, transition: transition)
    }
    
    func failedToSceneBy(nameScene: String) {
        let scene = (nameScene == "FiledScene") ? GameScene(size: self.size) : FailedScene(size: self.size)
        
        let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
        
        scene.scaleMode = .aspectFill

        self.view?.presentScene(scene, transition: transition)
        
    }
        
        func failedTimeToSceneBy(nameScene: String) {
            let scene = (nameScene == "FiledTimeScene") ? GameScene(size: self.size) : FailedTimeScene(size: self.size)
            
            let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
            
            scene.scaleMode = .aspectFill

            self.view?.presentScene(scene, transition: transition)
        }
//MARK: - HotCold
// func changeMenuSceneToHotCold(nameScene: String) {
//        let scene = (nameScene == "changeMenuSceneToHotCold") ? GameSceneHotCold(size: self.size) : MenuScene(size: self.size)
//        
//        let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
//        
//        scene.scaleMode = .aspectFill
//
//        self.view?.presentScene(scene, transition: transition)
//    }
//    
//    func failedToSceneHotCold(nameScene: String) {
//        let scene = (nameScene == "failedToSceneHotCold") ? GameSceneHotCold(size: self.size) : FailedScene(size: self.size)
//        
//        let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
//        
//        scene.scaleMode = .aspectFill
//
//        self.view?.presentScene(scene, transition: transition)
//        
//    }
//        
//        func failedTimeToSceneHotCold(nameScene: String) {
//            let scene = (nameScene == "failedTimeToSceneHotCold") ? GameSceneHotCold(size: self.size) : FailedTimeScene(size: self.size)
//            
//            let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
//            
//            scene.scaleMode = .aspectFill
//
//            self.view?.presentScene(scene, transition: transition)
//        }
    func playSoundFX(_ action: SKAction) {
        self.run(action)
    }
    
}
