//
//  GameVariables.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 9/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//
import SpriteKit
import GameplayKit
import Foundation

//will hold the different variables for the game
struct GameVariables{
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
}
