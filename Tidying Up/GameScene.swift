//
//  GameScene.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//      load the player in the gamescene.sks
    var player = SKSpriteNode()
//      array that will hold the different type of animation
    var joystickactive = false
    var xJoystickDelta = CGFloat();
    var yJoystickDelta = CGFloat();
     var joystick = SKSpriteNode(imageNamed: "joystick");
    var base = SKSpriteNode(imageNamed: "base");
    var Cam = SKCameraNode()
    var actionbutton = SKSpriteNode(imageNamed: "joystick")
    var actionlabel = SKLabelNode(text: "test")
    var actionbuttonClicked = false
    var idlearray = [SKTexture]()
    var runningarray = [SKTexture()];
    var bag = [item]()
    var gameplayStart = false
    var TimeLabelNode = SKLabelNode()
    var CounterTimer = Timer()
    var CounterStartTime = 90
    var Gameover = false
    var kitchen = SKSpriteNode()
    var clothes = SKSpriteNode()
    var baconBurger = SKSpriteNode()
    
//    enum playerstatus {
//        case idle,running,die
//    }
    struct Category_mask {
        static let player = 0x1 << 0 // 1
        static let food = 0x1 << 1 // 2
        let fridge =  0x1 << 2 // 4
        let dishes =  0x1 << 3 // 8
        let sink =  0x1 << 4 // 16
        let wardrobe = 0x1 << 5 // 32
        let bed = 0x1 << 6  //64
        let book = 0x1 << 7 //128
        let broom = 0x1 << 8 //256
        let clothes = 0x1 << 9 //512
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
        CounterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DecrementCounter), userInfo: nil, repeats: true)
        
        
 
    }
    //decrement the counter as the game starts
    @objc func DecrementCounter() {
       
        if CounterStartTime <= 1 {
            Gameover = true
            GameOverReturnToLevelSelection()
        }
        CounterStartTime -= 1
//        TimeLabelNode.text = "\(CounterStartTime)"
        
        let minutes = CounterStartTime/60
        let  seconds = CounterStartTime % 60  //get remainder
        TimeLabelNode.text = "\(minutes):\(seconds)"
    }
    //go back to the level selection screen and show the if level or objective is complete
    func GameOverReturnToLevelSelection() {
        print("hello")
    }
    //function called when a node contact another node
    func didBegin(_ contact: SKPhysicsContact) {
        var firstbody: UInt32 = 0
        var secondbody: UInt32 = 0
        var firstbodynode = SKNode()
        var secondbodynode = SKNode()
        //let the player alwasy be firstbody
        if(contact.bodyA.categoryBitMask == 1)
        {
            firstbody = contact.bodyA.categoryBitMask
            firstbodynode = contact.bodyA.node!
            secondbody = contact.bodyB.categoryBitMask
            secondbodynode = contact.bodyB.node!
        }
        if(contact.bodyB.categoryBitMask == 1){
            firstbody = contact.bodyB.categoryBitMask
            firstbodynode = contact.bodyB.node!
            secondbody = contact.bodyA.categoryBitMask
            secondbodynode = contact.bodyA.node!
        }
        
        if(actionbuttonClicked == true){
            
            if(firstbody == 1) // player hit something
            {
                let bitwise = firstbody | secondbody
                switch bitwise   //check what that something is
                {
                case let bitwise where bitwise == 3:
                    print("grab food")
                    actionlabel.text = "pick up"
                    let food = item(_name: secondbodynode.name!, _category_Bitmask: 2)
                    bag.append(food)
                    secondbodynode.removeFromParent()
                case let bitwise where bitwise == 5:
                    print("contact fridge")
                    let bagcontainfood = bag.contains{$0.category_Bitmask == 2}
                    if (bagcontainfood) {
                        print("food succesfully put")
                    }
                case let bitwise where bitwise == 9:
                    print("picked up dirty dishes")
                default:
                    print("something went wrong error")
                }
            
            }
        }
//        if (actionbuttonClicked == true){
//            actionlabel.text = "pick up"
//            bag.append(clothes)
//            clothes.removeFromParent()
//        }
    }
    func InitializeItems(){
        clothes = self.childNode(withName: "clothes") as! SKSpriteNode;
        baconBurger = self.childNode(withName: "baconBurger") as! SKSpriteNode
    }
    func InitializeFurniture() {
        kitchen = self.childNode(withName: "kitchen") as! SKSpriteNode;
    }
    func IntializeArray() {
        for i in 1..<16
              {
                  let textturename2 = "CTRun (\(i))"
                  let textturename = "CTIdle (\(i))"
                  idlearray.append(SKTexture(imageNamed: textturename))
                  runningarray.append(SKTexture(imageNamed: textturename2))
              }
    }
    //intialize the camera and all its children, the player controls
    func IntializeCameraNChild(){
       
        Cam = self.childNode(withName: "Cam") as! SKCameraNode
        self.camera = Cam
        let zeroRange = SKRange(constantValue: 0)
        let playerconstraints = SKConstraint.distance(zeroRange, to: player)
        let levelconstraint = SKConstraint.positionY(SKRange(constantValue: 0))
        Cam.constraints = [playerconstraints,levelconstraint]
        base = Cam.childNode(withName: "base") as! SKSpriteNode
        joystick = Cam.childNode(withName: "joystick") as! SKSpriteNode
        actionbutton = Cam.childNode(withName: "actionButton") as! SKSpriteNode
        TimeLabelNode = Cam.childNode(withName: "timerNode") as! SKLabelNode
        actionbutton.addChild(actionlabel)
        actionlabel.fontSize = 56
        actionlabel.position = CGPoint(x:0 , y: 0)
        actionlabel.text = "A"
        actionlabel.fontColor = UIColor.white
        actionlabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        actionlabel.fontName = "HelveticaNeue-Bold"

        
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
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {

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
