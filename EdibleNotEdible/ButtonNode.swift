//
//  ButtonNode.swift
//  EdibleNotEdible
//
//  Created by mac on 20.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {

    init(imageNode: String, position: CGPoint, xScale: CGFloat, yScale: CGFloat) {
        
        let texture = SKTexture(imageNamed: imageNode)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.position = position
        self.xScale = xScale
        self.yScale = yScale
    }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
