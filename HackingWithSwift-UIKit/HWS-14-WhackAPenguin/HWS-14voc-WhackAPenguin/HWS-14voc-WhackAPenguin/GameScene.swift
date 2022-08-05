//
//  GameScene.swift
//  HWS-14voc-WhackAPenguin
//
//  Created by Massimo Savino on 2022-07-15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private struct Constants {
        static let first = "first"
        static let second = "second"
        static let third = "third"
        static let fourth = "fourth"
        static let whackBackground = "whackBackground"
        static let chalkduster = "Chalkduster"
        static let whackHole = "whackHole"
        static let adjustmentFactor = CGFloat(170)
        static let charFriend = "charFriend"
        static let charEnemy = "charEnemy"
        static let gameOver = "gameOver"
        static let pointNineNineOne = 0.991
        static let whackMask = "whackMask"
        static func gameScoreText(score: Int) -> String {
            return "Score: \(score)"
        }
    }
    // parameters[0] = upperLimit
    // parameters[1] = x
    // parameters[2] = y
    let firstFloats: [CGFloat] = [5, 100, 410]
    let secondFloats: [CGFloat] = [4, 180, 320]
    let thirdFloats: [CGFloat] = [5, 100, 230]
    let fourthFloats: [CGFloat] = [4, 180, 140]
    
    // randoms[0] = upperLimit
    // randoms[1] = slot location
    let randomA: [Int] = [4, 1]
    let randomB: [Int] = [8, 2]
    let randomC: [Int] = [10, 3]
    let randomD: [Int] = [11, 4]

    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var slots = [WhackSlot]()
    var popupTime = 0.85
    var numRounds = 0
    
    private let slotz = [
        Constants.first,
        Constants.second,
        Constants.third,
        Constants.fourth
    ]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: Constants.whackBackground)
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: Constants.chalkduster)
        gameScore.text = Constants.gameScoreText(score: score)
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode =  .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        scheduleSlotCreation()
    }
    
    // MARK: - Slot creation
    
    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: Constants.whackHole)
        addChild(sprite)
    }
    
    func createSlot(at position: CGPoint) {
        print("\(#function) :: ")
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        print("\(#function) :: slot @ \(position)")
        slots.append(slot)
    }
    
    func createEnemy() {
        numRounds += 1
        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }
            let gameOver = SKSpriteNode(imageNamed: Constants.gameOver)
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            return
        }
        popupTime *= Constants.pointNineNineOne
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        schedulePopUpCreation()
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }
    
    func iterateSlotCreation(
        upperLimit: Int, x: CGFloat, y: CGFloat) {
            for i in 0 ..< upperLimit { createSlot(at: CGPoint(x: (x + (CGFloat(i) * Constants.adjustmentFactor)), y: y)) }
    }
    
    func scheduleSlotCreation()  {
        iterateSlotCreation(upperLimit: Int(firstFloats[0]), x: firstFloats[1], y: firstFloats[2])
        iterateSlotCreation(upperLimit: Int(secondFloats[0]), x: secondFloats[1], y: secondFloats[2])
        iterateSlotCreation(upperLimit: Int(thirdFloats[0]), x: thirdFloats[1], y: thirdFloats[2])
        iterateSlotCreation(upperLimit: Int(fourthFloats[0]), x: fourthFloats[1], y: fourthFloats[2])
    }
    
    func iteratePopUpCreation(upperLimit: Int, iteration: Int) {
        if Int.random(in: 0...12) > upperLimit { slots[iteration].show(hideTime: popupTime)}
    }
    
    func schedulePopUpCreation() {
        iteratePopUpCreation(upperLimit: randomA[0], iteration: randomA[1])
        iteratePopUpCreation(upperLimit: randomB[0], iteration: randomB[1])
        iteratePopUpCreation(upperLimit: randomC[0], iteration: randomC[1])
        iteratePopUpCreation(upperLimit: randomD[0], iteration: randomD[1])
    }
    
    // MARK: - The rest
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
            if !whackSlot.isVisible { continue }
            if whackSlot.isHit { continue }
            whackSlot.hit()
            
            if node.name == Constants.charFriend {
                score -= 5
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                
            } else if node.name == Constants.charEnemy {
                guard let whackSlot = node.parent?.parent as? WhackSlot else { return }
                if !whackSlot.isVisible { continue }
                if whackSlot.isHit { continue }
                
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                whackSlot.hit()
                score += 1
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
//            for node in tappedNodes {
//                if node.name == Constants.charFriend {
//                    // Player should not have whacked this specific penguin
//                    let whackSlot = node.parent!.parent as! WhackSlot
//                    if !whackSlot.isVisible { continue }
//                    if whackSlot.isHit { continue }
//                    whackSlot.hit()
//                    score -= 5
//                    run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
//                } else if node.name == Constants.charEnemy {
//                    let whackSlot = node.parent!.parent as! WhackSlot
//                    if !whackSlot.isVisible { continue }
//                    if whackSlot.isHit { continue }
//
//                    whackSlot.charNode.xScale = 0.85
//                    whackSlot.charNode.yScale = 0.85
//                    whackSlot.hit()
//                    score += 1
//                    run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
//
//                }
//            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
