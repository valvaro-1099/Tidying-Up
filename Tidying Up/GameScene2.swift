//
//  GameScene2.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 13/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene2: SKScene, SKPhysicsContactDelegate {
    
//      load the player in the gamescene.sks
    var player = SKSpriteNode(imageNamed: "CTIdle (1)")
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
    var bagshow = SKShapeNode()
    var baglabel1 = SKLabelNode()
    var baglabel2 = SKLabelNode()
    var baglabel3 = SKLabelNode()
    var baglabel4 = SKLabelNode()
    var baglabel5 = SKLabelNode()
    var baglabel6 = SKLabelNode()
    var baglabel7 = SKLabelNode()
    var baglabel8 = SKLabelNode()
    var baglabel9 = SKLabelNode()
    var gameplayStart = false
    var TimeLabelNode = SKLabelNode()
    var CounterTimer = Timer()
    var CounterStartTime = 90
    var ItemArray = [SKSpriteNode]()
    var FurnitureArray = [SKSpriteNode]()
    var Objective = [SKSpriteNode]()
    
    
    var Gameover = false
    


    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        intializeWorld()
        initializePlayer()
        InitializeItems()
        InitializeFurniture()
        IntializeArray()
        IntializeCameraNChild()
        CounterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DecrementCounter), userInfo: nil, repeats: true)
        ItemArray = collectallwithname(array: ItemArray, Category: "Item")
        FurnitureArray = collectallwithname(array: FurnitureArray, Category: "Furniture")
    }
    
    
    //set the border for the world and set it so it handles it own collision
    func intializeWorld(){
        self.physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0.0
        border.restitution = 1.0
        self.physicsBody = border
    }
    
    
    //intialize the player
    func initializePlayer(){
        player.position = CGPoint(x: 0, y: 0)
        player.size = CGSize(width: 204, height: 258)
        self.addChild(player)
    }
    func intializeBag(){
        self.addChild(bagshow)
        bagshow  = SKShapeNode(rectOf: CGSize(width: 917.721, height: 632.836))
        bagshow.position = player.position
        bagshow.isHidden = true
        bagshow.addChild(baglabel1)
        baglabel1.position = CGPoint(x: -30.342, y: 28.024)
        bagshow.addChild(baglabel2)
        baglabel2.position = CGPoint(x: -30.342, y: 3.435)
        bagshow.addChild(baglabel3)
        baglabel3.position = CGPoint(x: -30.342, y: -22.392)
        bagshow.addChild(baglabel4)
        baglabel4.position = CGPoint(x: -2.033, y: 28.024)
        bagshow.addChild(baglabel5)
        baglabel5.position = CGPoint(x: -2.033, y: 3.435)
        bagshow.addChild(baglabel6)
        baglabel6.position = CGPoint(x: -2.033, y: -22.392)
        bagshow.addChild(baglabel7)
        baglabel7.position = CGPoint(x: 24.535, y: 28.024)
        bagshow.addChild(baglabel8)
        baglabel8.position = CGPoint(x: 24.535, y: 3.435)
        bagshow.addChild(baglabel9)
        baglabel9.position = CGPoint(x: 24.535, y: -22.392)
        
    }
    //add the item into the bag
    func addbag(_itemname:String, _category:UInt32,_removenode: SKNode){
        //check if the bag is full
        if(bag.count >= 9)
        {
            print("bag is full")
        }
        else
        {
            //add item to bag
            print("additem to bag")
            let itemadded = item(_name: _itemname, _category_Bitmask: _category)
            bag.append(itemadded)
            _removenode.removeFromParent()
            //check which label is not null to fill it with text
            if(baglabel1.text == "")
            {
                baglabel1.text  = _itemname
                return
            }
            if(baglabel2.text == "")
            {
                baglabel2.text  = _itemname
                return
            }
            if(baglabel3.text == "")
            {
                baglabel3.text  = _itemname
                return
            }
            if(baglabel4.text == "")
            {
                baglabel4.text  = _itemname
                return
            }
            if(baglabel5.text == "")
            {
                baglabel5.text  = _itemname
                return
            }
            if(baglabel6.text == "")
            {
                baglabel6.text  = _itemname
                return
            }
            if(baglabel7.text == "")
            {
                baglabel7.text  = _itemname
                return
            }
            if(baglabel8.text == "")
            {
                baglabel8.text  = _itemname
                return
            }
            if(baglabel9.text == "")
            {
                baglabel9.text  = _itemname
                return
            }
            
        }
        
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
    }
    func InitializeItems(){
       
    }
    func InitializeFurniture() {
     
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
        self.camera = Cam
        self.addChild(Cam)
        Cam.xScale = 1
        Cam.yScale = 1
        let zeroRange = SKRange(constantValue: 0)
        let playerconstraints = SKConstraint.distance(zeroRange, to: player)
        let levelconstraint = SKConstraint.positionY(SKRange(constantValue: 0))
        Cam.constraints = [playerconstraints,levelconstraint]
        Cam.addChild(base)
        base.size = CGSize(width: 425, height: 254)
        base.position = CGPoint(x: -1022.82, y: -359.71)
        Cam.addChild(joystick)
        joystick.size = CGSize(width: 246.247, height: 140.706)
        joystick.position = CGPoint(x: -1022.809, y: -359.71)
        Cam.addChild(actionbutton)
        actionbutton.size = CGSize(width: 318.607, height: 192.073)
        actionbutton.position = CGPoint(x: 1092.942, y: -361.297)
        Cam.addChild(TimeLabelNode)
        TimeLabelNode.position = CGPoint(x: 0, y: 434.581)
        TimeLabelNode.fontSize = 100
        TimeLabelNode.fontName = "HelveticaNeue-Bold"
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
    func collectallwithname(array: [SKSpriteNode], Category: String) -> [SKSpriteNode]{
        var _Array = array
       self.enumerateChildNodes(withName: Category){
        node, stop in

         _Array.append(node as! SKSpriteNode)
        }
        return _Array
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
