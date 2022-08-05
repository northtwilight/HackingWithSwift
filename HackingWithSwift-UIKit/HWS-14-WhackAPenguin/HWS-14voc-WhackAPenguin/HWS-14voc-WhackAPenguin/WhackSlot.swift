//
//  WhackSlot.swift
//  HWS-14voc-WhackAPenguin
//
//  Created by Massimo Savino on 2022-07-16.
//

import Foundation
import SpriteKit
import UIKit

class WhackSlot: SKNode {
    private struct Constants {
        static let whackHole = "whackHole"
        static let whackMask = "whackMask"
        static let penguinGood = "penguinGood"
        static let penguinEvil = "penguinEvil"
        static let character = "character"
        static let charFriend = "charFriend"
        static let charEnemy = "charEnemy"
        static let zeroPointZeroFive = 0.05
        static let zeroPointFive = 0.5
        static let zeroPointTwoFive = 0.25
        
    }
    
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: Constants.whackHole)
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: Constants.whackMask)
        
        charNode = SKSpriteNode(imageNamed: Constants.penguinGood)
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = Constants.character
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: Constants.zeroPointZeroFive))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: Constants.penguinGood)
            charNode.name = Constants.charFriend
        } else {
            charNode.texture = SKTexture(imageNamed: Constants.penguinEvil)
            charNode.name = Constants.charEnemy
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [unowned self] in
            self.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: Constants.zeroPointZeroFive))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        let delay = SKAction.wait(forDuration: Constants.zeroPointTwoFive)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: Constants.zeroPointFive)
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        charNode.run(SKAction.sequence( [delay, hide, notVisible] ))
    }
}
