//
//  Tutorial.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit
//create a new custom shader object
func shaderWithFilename( _ filename: String?, fileExtension: String?, uniforms: [SKUniform] ) -> SKShader {
        let path = Bundle.main.path( forResource: filename, ofType: fileExtension )
        let source = try! NSString( contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue )
        let shader = SKShader( source: source as String, uniforms: uniforms )
        return shader
}

class TutorialScene: SKScene, SKPhysicsContactDelegate
{
    var comment = SKShapeNode()
    var commentText1 = SKLabelNode()
    var manager = SKSpriteNode()
    var manager2 = SKSpriteNode()
    var comment2 = SKShapeNode()
    var commentText2 = SKLabelNode()
  
    var manager3 = SKSpriteNode()
    var comment4 = SKShapeNode()
    var commentText4 = SKLabelNode()
    var player = SKSpriteNode()
    //      array that will hold the different type of animation
    var joystickactive = false
    var xJoystickDelta = CGFloat();
    var yJoystickDelta = CGFloat();
    var joystick = SKSpriteNode();
    var base = SKSpriteNode();
    var Cam = SKCameraNode()
    var actionbutton = SKSpriteNode()
    var actionlabel = SKLabelNode()
    var actionbuttonClicked = false
    var idlearray = [SKTexture]()
    var runningarray = [SKTexture()];
    var process = SKShapeNode()
    var processaniamtion = CABasicAnimation()
    var bedmaded = false
    //to get around the process animation
    let strokeSizeFactor = CGFloat( 2.0 )
    var strokeShader: SKShader!
    var strokeLengthUniform: SKUniform!
    var _strokeLengthFloat: Float = 0.0
    var strokeLengthKey: String!
    var strokeLengthFloat: Float {
        get {
            return _strokeLengthFloat
        }
        set( newStrokeLengthFloat ) {
            _strokeLengthFloat = newStrokeLengthFloat
            strokeLengthUniform.floatValue = newStrokeLengthFloat
        }
    }
    var bagOpenned = false
    var bag = [item]()
    var bagshow = SKSpriteNode()
    var itemlabel1 = SKLabelNode()
    var itemlabel2 = SKLabelNode()
    var itemlabel3 = SKLabelNode()
    var itemlabel4 = SKLabelNode()
    var itemlabel5 = SKLabelNode()
    var itemlabel6 = SKLabelNode()
    var itemlabel7 = SKLabelNode()
    var itemlabel8 = SKLabelNode()
    var itemlabel9 = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        self.physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0.0
        border.restitution = 1.0
        self.physicsBody = border
         player = self.childNode(withName: "player") as! SKSpriteNode;
        IntializeCameraNChild()
        IntializeArray()
        setup()
    
    }
    //setup the tutorial text for the player
    func setup() {
        //tutorial text 1
        manager = self.childNode(withName: "manager") as! SKSpriteNode
        makecomment(manager: manager, text: "Welcome Username! Thank you for applying for this profession. Firstly before one becomes a professional cleaner one must go through some training. Lets get started shall we!")
        
        //tutorial text 2
        manager2 = self.childNode(withName: "manager2") as! SKSpriteNode
        makecomment(manager: manager2, text: "First lets start with the basicTo make a bed you have to press the A button continously while standing near the bed. Do this until the progress bar is completed")
        
        //tutorial text 3
        manager3 = self.childNode(withName: "manager3") as! SKSpriteNode
        makecomment(manager: manager3, text: "Now to pick up stuff press the A button. The item will be stored in your bag. You can check your bag by touching the player. After picking up the item put each item in there respectively places.")

        //setup the process bar for the bed
        strokeLengthKey = "u_current_percentage"
        strokeLengthUniform = SKUniform( name: strokeLengthKey, float: 0.0 )
        let uniforms: [SKUniform] = [strokeLengthUniform]
        strokeShader = shaderWithFilename( "animateStroke", fileExtension: "fsh", uniforms: uniforms )
        strokeLengthFloat = 0.0
       let bed = self.childNode(withName: "bed") as! SKSpriteNode
       let topofbed = CGPoint(x: bed.frame.midX, y: bed.position.y + bed.frame.width)
       let circularpath = UIBezierPath(arcCenter: topofbed, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
       process.path = circularpath.cgPath
       process.lineWidth = 10
       process.strokeColor = UIColor.green
       process.strokeShader = strokeShader
       self.addChild(process)
        
        //the bagUI will show what is in the bag, but for now hide it
        bagshow = Cam.childNode(withName: "bagShow") as! SKSpriteNode
        bagshow.isHidden = true
        
        //init all the label
        itemlabel1 = bagshow.childNode(withName: "item1") as! SKLabelNode
        itemlabel2 = bagshow.childNode(withName: "item2") as! SKLabelNode
        itemlabel3 = bagshow.childNode(withName: "item3") as! SKLabelNode
        itemlabel4 = bagshow.childNode(withName: "item4") as! SKLabelNode
        itemlabel5 = bagshow.childNode(withName: "item5") as! SKLabelNode
        itemlabel6 = bagshow.childNode(withName: "item6") as! SKLabelNode
        itemlabel7 = bagshow.childNode(withName: "item7") as! SKLabelNode
        itemlabel8 = bagshow.childNode(withName: "item8") as! SKLabelNode
        itemlabel9 = bagshow.childNode(withName: "item9") as! SKLabelNode
     
    }
    //make the comment for the tutorial
    func makecomment(manager: SKSpriteNode, text: String){
         let comment = SKShapeNode(rect: CGRect(x: 0, y: -150, width: 3000, height: 200))
        comment.path = UIBezierPath(roundedRect: CGRect(x: (manager.position.x + manager.frame.width*0.5), y: 260, width: 1950, height: 220), cornerRadius: 50).cgPath
        comment.fillColor = UIColor.gray
        let commentText = SKLabelNode()
        comment.addChild(commentText)
        commentText.position = CGPoint(x: comment.frame.midX, y: comment.frame.midY)
        commentText.verticalAlignmentMode = .center
        commentText.horizontalAlignmentMode = .center
        commentText.lineBreakMode = .byWordWrapping
        commentText.numberOfLines = 0
        commentText.preferredMaxLayoutWidth = comment.frame.size.width
        commentText.color = UIColor.white
        commentText.fontName = "HelveticaNeue"
        commentText.fontSize = 50
        commentText.text = "Now put the things where they belong. Put the food in the fridge, put the clothes in the wardrobe, put the dishes in the sink, put the books in the bookshelf"
        self.addChild(comment)
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
        actionbutton.addChild(actionlabel)
        actionlabel.fontSize = 56
        actionlabel.position = CGPoint(x:0 , y: 0)
        actionlabel.text = "A"
        actionlabel.fontColor = UIColor.white
        actionlabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        actionlabel.fontName = "HelveticaNeue-Bold"
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
    func didBegin(_ contact: SKPhysicsContact) {
      
        if(contact.bodyA.node == nil && contact.bodyB.node == nil){
            return
        }
        else
        {
            //let the player alwasy be firstbody
            var firstbody: UInt32 = 0
            var secondbody: UInt32 = 0
            var firstbodynode = SKNode()
            var secondbodynode = SKNode()
            var secondbodynodeName = secondbodynode.name
            if(contact.bodyA.categoryBitMask == 1)
                {
                    firstbody = contact.bodyA.categoryBitMask
                    firstbodynode = contact.bodyA.node!
                    secondbody = contact.bodyB.categoryBitMask
                    secondbodynode = contact.bodyB.node!
                    secondbodynodeName = contact.bodyB.node!.name
                }
                if(contact.bodyB.categoryBitMask == 1){
                    firstbody = contact.bodyB.categoryBitMask
                    firstbodynode = contact.bodyB.node!
                    secondbody = contact.bodyA.categoryBitMask
                    secondbodynode = contact.bodyA.node!
                    secondbodynodeName = contact.bodyA.node!.name
                }
                 if(actionbuttonClicked == true)
                 {
                    if(firstbody == 1) // player hit something
                    {
                        let bitwise = firstbody | secondbody
                        switch bitwise   //check what that something is
                        {
                            case let bitwise where bitwise == 65: // bed
                                print("bitch")
                                if(bedmaded == false) {
                                    strokeLengthFloat += 0.05
                                    if strokeLengthFloat > 1.0 {
                                        strokeLengthFloat = 0.0
                                        bedmaded = true
                                        return
                                        }
                                    }
                                        
                            case let bitwise where bitwise == 5: //fridge
                                print("touch fridge")
                            case let bitwise where bitwise == 3: //food
                                print("touch food")
                                addbag(_itemname: secondbodynodeName!, _category: secondbody, _removenode: secondbodynode)
                            case let bitwise where bitwise == 17: // sink
                                print("touch sink")
                            case let bitwise where bitwise == 9: // Dishes
                                print("touch dishes")
                                addbag(_itemname: secondbodynodeName!, _category: secondbody, _removenode: secondbodynode)
                            case let bitwise where bitwise == 513: // Clothes
                                print("touche clothes")
                                addbag(_itemname: secondbodynodeName!, _category: secondbody, _removenode: secondbodynode)
                            case let bitwise where bitwise == 33: // wardrobe
                            print("touche wardrobe")
                            case let bitwise where bitwise == 129: // book // not working
                                print("touch book")
                                addbag(_itemname: secondbodynodeName!, _category: secondbody, _removenode: secondbodynode)
                            case let bitwise where bitwise == 1024: // bookshelf
                                print("touche bookshelf")
                            default:
                                print("something went wrong")
                        }
                           
                    }
                }
            
        }
        
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
            if(itemlabel1.text == "")
            {
                itemlabel1.text  = _itemname
            }
            if(itemlabel2.text == "")
            {
                itemlabel2.text  = _itemname
            }
            if(itemlabel3.text == "")
            {
                itemlabel3.text  = _itemname
            }
            if(itemlabel4.text == "")
            {
                itemlabel4.text  = _itemname
            }
            if(itemlabel5.text == "")
            {
                itemlabel5.text  = _itemname
            }
            if(itemlabel6.text == "")
            {
                itemlabel6.text  = _itemname
            }
            if(itemlabel7.text == "")
            {
                itemlabel7.text  = _itemname
            }
            if(itemlabel8.text == "")
            {
                itemlabel8.text  = _itemname
            }
            if(itemlabel9.text == "")
            {
                itemlabel9.text  = _itemname
            }
            
        }
        
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

            for touch in touches {
                let locationincamera = touch.location(in: self.Cam)
                let location = touch.location(in: self)
                //check if the player is touch
                if(player.frame.contains(location))
                {
                    //check if bag is closed open it, if the bag is already open the close it
                    if(bagOpenned == false){
                        //open bag
                        bagOpenned = true
                        bagshow.isHidden = false
                    }
                    else if(bagOpenned == true) {
                        //close bag
                        bagOpenned = false
                        bagshow.isHidden = true
                    }
                }
                
                //chekck if the usertouch the action button
                if (actionbutton.frame.contains(locationincamera))
                {
                    actionbuttonClicked = true
                }
                //check if the usertouch the joystick
                if (base.frame.contains(locationincamera)){
                    joystickactive = true
                    player.run(SKAction.repeatForever(SKAction.animate(with: runningarray, timePerFrame: 0.1, resize: false, restore: true)))
                }
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
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
           
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

    override func update(_ currentTime: TimeInterval)
    {
            
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
