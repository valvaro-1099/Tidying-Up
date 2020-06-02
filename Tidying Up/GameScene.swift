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
    var player = SKSpriteNode()
//      array that will hold the different type of animation
    var idlearray = [SKTexture]()
    var runningarray = [SKTexture()];
    var base = SKSpriteNode(imageNamed: "base")
    var joystick = SKSpriteNode(imageNamed: "joystick")
    var joystickactive = false
    var xJoystickDelta = CGFloat();
    var yJoystickDelta = CGFloat();
    var Cam = SKCameraNode()
    enum playerstatus {
        case idle,running,die
    }
    var currentstatus:playerstatus = .idle


    override func didMove(to view: SKView) {
        
        self.scaleMode = .fill
        player = self.childNode(withName: "player") as! SKSpriteNode;
        
        for i in 1..<10
        {
            let textturename2 = "Run (\(i))"
            let textturename = "Idle (\(i))"
            idlearray.append(SKTexture(imageNamed: textturename))
            runningarray.append(SKTexture(imageNamed: textturename2))
        }
        
        self.camera = Cam
        self.addChild(Cam)
        player.run(SKAction.repeatForever(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: true)), withKey: "Idle")
//        
//        Cam.addChild(base)
//        Cam.addChild(joystick)
//        joystick.position = base.position
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        print("this is base frame \(base.frame.debugDescription)")
//        print("this is base position \(base.position)")
//        for touch in touches {
//
//            let location = touch.location(in: self)
//            print("below is the user touch location")
//            print(location)
//
//            if (base.frame.contains(location)){
//
//                joystickactive = true
//            }
//            else
//            {
//
//                joystickactive = false
//            }
//        }
        for touch in touches {
                  let location = touch.location(in: self)
                  player.removeAction(forKey: "Idle")
//            player = SKSpriteNode(imageNamed: "Run \(1)")
                  player.run(SKAction.group([SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: false)),SKAction.move(to: location, duration: 2)]), withKey: "Running")
                  
              
              }
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        for touch in touches
//        {
//            if(joystickactive == true)
//            {
//            let location = touch.location(in: self)
//            let vector = CGVector(dx: location.x - base.position.x, dy: location.y - base.position.y)
//            xJoystickDelta = location.x - base.position.x
//            yJoystickDelta = location.y - base.position.y
//            let angle = atan2(vector.dy, vector.dx)
////            let deg = angle * CGFloat(180 / M_PI);
//
//            let lenght:CGFloat = base.frame.size.height / 2
//                  let xDist: CGFloat = sin(angle) * lenght
//                  let yDist: CGFloat = cos(angle) * lenght
//
//
//            joystick.position = CGPoint(x: base.position.x - xDist, y: base.position.y + yDist)
//
//            if (base.frame.contains(location))
//            {
//
//                       joystick.position = location
//            }else
//            {
//
//                    joystick.position = CGPoint(x: base.position.x - xDist, y: base.position.y + yDist)
//            }
//
//            }
//        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
//        for touch in touches {
//            let location = touch.location(in: self)
//            player.removeAllActions()
//            player.run(SKAction.group([SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: false)),SKAction.move(to: location, duration: 2)]), withKey: "Running")
//
//
//        }
        
        player.removeAction(forKey: "Running")
        player.run(SKAction.repeatForever(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: false)), withKey: "Idle")

        
//        if (joystickactive == true)
//        {
//            let move:SKAction = SKAction.move(to: base.position, duration: 0.2)
//            move.timingMode = .easeOut
//            joystick.run(move)
//            xJoystickDelta = 0
//            yJoystickDelta = 0
//        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        Cam.position = player.position
//        player.
        
//        switch (currentstatus) {
//        case .idle:
//            player.run(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: true), withKey: "idle")
//            print("idle")
//        case .running:
//            player.run(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: true), withKey: "running")
//            print("running")
//        case .die:
//            print("die")
//        }
        
        
//        if(joystickactive == true)
//        {
////        center the camera with camera
//        Cam.position = player.position
//
//
//
////        update the player according to the movement of the
//        let xScale = 0.03 //adjust to your preference
//        let yScale = 0.03//adjust to your preference
//        let xAdd = CGFloat(xScale) * self.xJoystickDelta
//        let yAdd = CGFloat(yScale) * self.yJoystickDelta
//        self.player.position.x += xAdd
//        self.player.position.y += yAdd
//        }
    }
}
