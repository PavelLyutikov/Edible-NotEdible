//
//  Sound.swift
//  EdibleNotEdible
//
//  Created by Pavel Lyutikov on 22.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import SpriteKit

enum Sound: String {
    case clock, fail, tap, timeIsUp, win
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + "Sound.wav", waitForCompletion: false)
    }
}

extension SKAction {
    static let playGameMusic: SKAction = playSoundFileNamed("backMusic.mp3", waitForCompletion: false)
}
