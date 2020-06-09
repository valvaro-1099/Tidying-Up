//
//  GameScene.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//      load the player in the gamescene.sks
    var player = SKSpriteNode()
//      array that will hold the different type of animation
    var idlearray = [SKTexture]()
    var runningarray = [SKTexture()];
    var joystickactive = false
    var xJoystickDelta = CGFloat();
    var yJoystickDelta = CGFloat();
     var joystick = SKSpriteNode(imageNamed: "joystick");
    var base = SKSpriteNode(imageNamed: "base");
    var kitchen = SKSpriteNode()
    var clothes = SKSpriteNode()
    var Cam = SKCameraNode()
    var actionbutton = SKSpriteNode(imageNamed: "joystick")
    var actionlabel = SKLabelNode(text: "test")
    var actionbuttonClicked = false
    var bag = [SKSpriteNode()]
//    enum playerstatus {
//        case idle,running,die
//    }
    struct Category_mask {
        let player = 1
        let pickableitem = 2
        let furniture = 4
        let enemy = 8
    }
    struct Contact_mask {
        let player = 1
        let pickableitem = 2
        let furniture = 3
        let enemy = 5
    }
//    var currentstatus:playerstatus = .idle


    override func didMove(to view: SKView) {
        
        self.scaleMode = .fill
        self.physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0.0
        border.restitution = 1.0
        self.physicsBody = border
        player = self.childNode(withName: "player") as! SKSpriteNode;

        InitializeItems()
        InitializeFurniture()
        IntializeArray()
        IntializeCameraNChild()
        
 
    }
    //function called when a node contact another node
    func didBegin(_ contact: SKPhysicsContact) {
        
        switch (Contact_mask) {
        case contact.bodyA.:
            <#code#>
        default:
            <#code#>
        }(contact.Contact_mask)
//        if (actionbuttonClicked == true){
//            actionlabel.text = "pick up"
//            bag.append(clothes)
//            clothes.removeFromParent()
//        }
    }
    func InitializeItems(){
        clothes = self.childNode(withName: "clothes") as! SKSpriteNode;
    }
    func InitializeFurniture() {
        kitchen = self.childNode(withName: "kitchen") as! SKSpriteNode;
    }
    func IntializeArray() {
        for i in 1..<10
              {
                  let textturename2 = "Run (\(i))"
                  let textturename = "Idle (\(i))"
                  idlearray.append(SKTexture(imageNamed: textturename))
                  runningarray.append(SKTexture(imageNamed: textturename2))
              }
    }
    //intialize the camera and all its children, the player controls
    func IntializeCameraNChild(){
        self.camera = Cam
        self.addChild(Cam)
        let zeroRange = SKRange(constantValue: 0)
        let playerconstraints = SKConstraint.distance(zeroRange, to: player)
        let levelconstraint = SKConstraint.positionY(SKRange(constantValue: 0))
        Cam.constraints = [playerconstraints,levelconstraint]
        base.size = CGSize(width: 256.998, height: 246.421)
        base.position = CGPoint(x: -484.908, y: -331.116)
        base.alpha = 0.6
        Cam.addChild(base)
        joystick.position = CGPoint(x:-484.907 , y: -331.117)
        joystick.size = CGSize(width: 160, height: 140)
        joystick.alpha = 0.6
        Cam.addChild(joystick)
        actionbutton.position = CGPoint(x:484.907 , y: -331.117)
        actionbutton.size = CGSize(width: 200, height: 180)
        actionbutton.alpha = 0.6
        Cam.addChild(actionbutton)
        actionbutton.addChild(actionlabel)
        actionlabel.fontSize = 56
        actionlabel.position = CGPoint(x:0 , y: -14.372)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self.Cam)
            if (actionbutton.frame.contains(location)){actionbuttonClicked = true}
            if (base.frame.contains(location)){
                joystickactive = true
                player.run(SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: true)))
            }
            else {joystickactive = false}
        }
        

//        for touch in touches {
//                  let location = touch.location(in: self)
//                  player.removeAction(forKey: "Idle")
////            player = SKSpriteNode(imageNamed: "Run \(1)")
//                  player.run(SKAction.group([SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: false)),SKAction.move(to: location, duration: 2)]), withKey: "Running")
//
//
//              }
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
//        for touch in touches
//        {
//            let location = touch.location(in: self)
//            let vector = CGVector(dx: location.x - base.position.x, dy: location.y - base.position.y)
//            let angle = atan2(vector.dy, vector.dx)
//            let length = base.frame.size.height/2
//            let XDistance = sin(angle - 1.5) * length
//            let YDistance = cos(angle - 1.5) * length
//
//            joystick.position
//        }
        for touch in touches
        {
            if(joystickactive == true)
            {
                let location = touch.location(in: self.Cam)
            let vector = CGVector(dx: location.x - base.position.x, dy: location.y - base.position.y)
            xJoystickDelta = location.x - base.position.x
            yJoystickDelta = location.y - base.position.y
            let angle = atan2(vector.dy, vector.dx)
            let lenght:CGFloat = base.frame.size.height / 2
            let xDist: CGFloat = sin(angle - 1.57079633) * lenght
            let yDist: CGFloat = cos(angle - 1.57079633) * lenght
            joystick.position = CGPoint(x: base.position.x - xDist, y: base.position.y + yDist)

            if (base.frame.contains(location))
            {
                        
                joystick.position = location
                
            }else
            {

                    joystick.position = CGPoint(x: base.position.x - xDist, y: base.position.y + yDist)
            }

            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
//        for touch in touches {
//            let location = touch.location(in: self)
//            player.removeAllActions()
//            player.run(SKAction.group([SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: false)),SKAction.move(to: location, duration: 2)]), withKey: "Running")
//
//
//        }
//
//        player.removeAction(forKey: "Running")
//        player.run(SKAction.repeatForever(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: false)), withKey: "Idle")
//

        if (joystickactive == true)
        {
            let move:SKAction = SKAction.move(to: base.position, duration: 0.2)
            move.timingMode = .easeOut
            joystick.run(move)
            xJoystickDelta = 0
            yJoystickDelta = 0
        }
        player.removeAllActions()
        player.run(SKAction.repeatForever(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: true)))
       
    }

    override func update(_ currentTime: TimeInterval) {
//            Cam.position = player.position
//        player.
        
//        switch (currentstatus) {
//        case .idle:
//            player.run(SKAction.animate(with: idlearray, timePerFrame: 0.1, resize: false, restore: false))
//            print("idle")
//        case .running:
//            player.run(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: false), withKey: "running")
//            print("running")
//        case .die:
//            print("die")
//        }
        
        
        if(joystickactive == true)
        {
//        update the player according to the movement of the
        let xScale = 0.03 //adjust to your preference
        let yScale = 0.03//adjust to your preference
        let xAdd = CGFloat(xScale) * self.xJoystickDelta
        let yAdd = CGFloat(yScale) * self.yJoystickDelta
        self.player.position.x += xAdd
        self.player.position.y += yAdd
        }
    }
}
