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
        
//        let transition = SKTransition.fade(with: .defBackground, duration: 0.3)
        let transition = SKTransition.push(with: .down, duration: 1)
        scene.scaleMode = .aspectFill

        self.view?.presentScene(scene, transition: transition)
    }
    
    func failedToSceneBy(nameScene: String) {
        let scene = (nameScene == "FiledScene") ? GameScene(size: self.size) : FailedScene(size: self.size)
        
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        scene.scaleMode = .aspectFill

        self.view?.presentScene(scene, transition: transition)
        
    }
        
        func failedTimeToSceneBy(nameScene: String) {
            let scene = (nameScene == "FiledTimeScene") ? GameScene(size: self.size) : FailedTimeScene(size: self.size)
            
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            scene.scaleMode = .aspectFill

            self.view?.presentScene(scene, transition: transition)
        }
    
    func failedSceneToGameScene(nameScene: String) {
        let scene = (nameScene == "FiledSceneToGameScene") ? GameScene(size: self.size) : FailedScene(size: self.size)
        
//        let transition = SKTransition.crossFade(withDuration: 0.5)
//        let transition = SKTransition.moveIn(with: .down, duration: 0.5)
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
