//
//  LabelNode.swift
//  EdibleNotEdible
//
//  Created by mac on 20.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit

class LabelNode: SKLabelNode {
    
    convenience init(text: String, fontSize: CGFloat, position: CGPoint, fontColor: UIColor) {
        self.init(fontNamed: Const.uiFont.rawValue)
        self.text = text
        self.fontSize = fontSize
        self.position = position
        self.fontColor = fontColor
    }

}
