//
//  GameScene.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//      load the player in the gamescene.sks
    lazy var player = self.childNode(withName: "player") as! SKSpriteNode;
//      array that will hold the different type of animation
    var idlearray = [SKTexture]()
    var runningarray = [SKTexture()]
    var moving = false
 
    override func didMove(to view: SKView) {
//        for loop to load all the assets for idle animation to the idlearray
        for i in 1..<16
        {
            let textturename = "Idle\(i)"
            idlearray.append(SKTexture(imageNamed: textturename))
        }
        for i in 1..<20
        {
            let texturename = "Run (\(i))"
            runningarray.append(SKTexture(imageNamed: texturename))
        }
       playeridle()
    }
//    drag type of touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAllActions()
        
        for touch in touches
        {
            
             let touchlocation = touch.location(in: self)
            player.position = touchlocation;
            player.run(SKAction.animate(with: runningarray, timePerFrame: 0.1))
            
            
        }
    }
//    for when the player is idle
    func playeridle()
    {
        removeAllActions()
        player.run(SKAction.repeatForever(SKAction.animate(with: idlearray, timePerFrame: 0.1)))
    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { player.run() }
//        }
//
    


    
//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
