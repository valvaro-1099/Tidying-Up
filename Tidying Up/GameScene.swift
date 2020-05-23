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
        
        self.scaleMode = .fill
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
