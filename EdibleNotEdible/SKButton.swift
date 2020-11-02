//
//  SKButton.swift
//  EdibleNotEdible
//
//  Created by mac on 02.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import SpriteKit

class SKButton: SKNode {
    var button: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode: SKCropNode
    private var action: () -> Void
    var isEnebled = true
    
    init(imageName: String, buttonAction: @escaping (() -> ())) {
        if imageName == "" {
            button = SKSpriteNode(color: .blue, size: CGSize(width: 40, height: 40))
        } else {
            button = SKSpriteNode(imageNamed: imageName)
        }
        mask = SKSpriteNode(color: .black, size: button.size)
        mask.alpha = 0
        
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        
        action = buttonAction
        
        super.init()
        isUserInteractionEnabled = true
        addNodes()
       // setupNodes()
    }
    
    func setupNodes() {
        button.zPosition = 0
    }
    
    func addNodes() {
        addChild(button)
        addChild(cropNode)
    }
    
    func disable() {
        isEnebled = false
        mask.alpha = 0.0
        button.alpha = 0.5
    }
    
    func enable() {
        isEnebled = true
        mask.alpha = 0.0
        button.alpha = 1.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnebled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if button.contains(location) {
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0.0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnebled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if button.contains(location) {
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run {
                        self.enable()
                        }]))
                } else {
                    
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
