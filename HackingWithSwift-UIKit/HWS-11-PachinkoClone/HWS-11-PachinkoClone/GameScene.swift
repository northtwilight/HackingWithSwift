//
//  GameScene.swift
//  HWS-11-PachinkoClone
//
//  Created by Massimo Savino on 2022-07-04.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private struct Constants {
        static let ballBlue = "ballBlue"
        static let ballCyan = "ballCyan"
        static let ballGreen = "ballGreen"
        static let ballGrey = "ballGrey"
        static let ballPurple = "ballPurple"
        static let ballRed = "ballRed"
        static let ballYellow = "ballYellow"
        
        static let sixtyFour = CGFloat(64)
        static let fontChalkduster = "Chalkduster"
        static let scoreZero = "Score: 0"
        static let edit = "Edit"

        static let scoreX = 980
        static let scoreY = 700
        
        static let editX = 80
        static let editY = scoreY
        
        static let editLabelDone = "Done"
        static let editLabelEdit = "Edit"
    }
    
    let ballColours = [
        Constants.ballBlue,
        Constants.ballCyan,
        Constants.ballGreen,
        Constants.ballGrey,
        Constants.ballPurple,
        Constants.ballRed,
        Constants.ballYellow]
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = Constants.editLabelDone
            } else {
                editLabel.text = Constants.editLabelEdit
            }
        }
    }
    func makeLabelNode(
        fontName: String,
        text: String,
        horizontalAlignmentMode:
        SKLabelHorizontalAlignmentMode = .right,
        position: CGPoint) -> SKLabelNode {
            let label = SKLabelNode()
            label.fontName = fontName
            label.text = text
            label.horizontalAlignmentMode = horizontalAlignmentMode
            label.position = position
            addChild(label)
            
            return label
        }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        addChild(background)
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        scoreLabel = makeLabelNode(
            fontName: Constants.fontChalkduster,
            text: Constants.scoreZero,
            position: CGPoint(
                x: Constants.scoreX,
                y: Constants.scoreY))
        
        editLabel = makeLabelNode(
            fontName: Constants.fontChalkduster,
            text: Constants.edit,
            position: CGPoint(
                x: Constants.editX,
                y: Constants.editY))
                
//        let bouncer = SKSpriteNode(imageNamed: "bouncer")
//        bouncer.position = CGPoint(x: 512, y: 0)
//        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
//        bouncer.physicsBody?.isDynamic = false
//        addChild(bouncer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let objects = nodes(at: location)
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    // create a box
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(
                        color: UIColor(
                            red: CGFloat.random(in: 0...1),
                            green: CGFloat.random(in: 0...1),
                            blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    addChild(box)
                } else {
                    // challenge 2: Only top part of screen allows for ball creation
                    if location.y >= 600 {
                        // create a ball, random colour
                        guard let randomBall = ballColours.randomElement() else { return }
                        let ball = SKSpriteNode(imageNamed: randomBall)
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        ball.physicsBody?.restitution = 0.4
                        ball.position = location
                        ball.name = "ball"
                        addChild(ball)
                    }
                }
            }
            
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        slotBase.position = position
        slotGlow.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
