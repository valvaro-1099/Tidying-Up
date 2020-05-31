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
   var Base = SKSpriteNode(imageNamed: "base")
    var joystick = SKSpriteNode(imageNamed: "jostick")
//    check if joystick is touch


    override func didMove(to view: SKView) {
        
        self.scaleMode = .fill
        for i in 1..<10
        {
            let textturename2 = "Run (\(i))"
            let textturename = "Idle (\(i))"
            idlearray.append(SKTexture(imageNamed: textturename))
            runningarray.append(SKTexture(imageNamed: textturename2))
        }
//        width: 194.09, height: 185.34)
        Base.size = CGSize(width: 194, height: 184)
        Base.position = CGPoint(x:-470.162 , y: -354.178)
        Base.addChild(joystick)
        joystick.position = Base.position;
        joystick.size = CGSize(width: 120, height: 140)
        
       
    }
////    drag type of touch
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//
//        for touch in touches
//        {
//
//            player.run(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: true))
//             let touchlocation = touch.location(in: self)
//            player.position = touchlocation;
//        }
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        player.run(SKAction.move(to: location, duration: 2))
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            let vector = CGVector(dx: location.x - Base.position.x, dy: location.y - Base.position.y)
            let angle = atan2(vector.dy, vector.dx)
//            let deg = angle * CGFloat(180 / M_PI);
            
            let lenght:CGFloat = Base.frame.size.height / 2 - 20
                  let xDist: CGFloat = sin(angle - 1.57079633) * lenght
                  let yDist: CGFloat = cos(angle - 1.57079633) * lenght

            
            joystick.position = CGPoint(x: Base.position.x - xDist, y: Base.position.y + yDist)

            if (Base.frame.contains(location))
            {

                       joystick.position = location
            }else
            {

                joystick.position = CGPoint(x: Base.position.x - xDist, y: Base.position.y + yDist)

            }

            
            
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
