//
//  item.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//
import SpriteKit
import GameplayKit
import Foundation

class item {
    var name:String
    var category_Bitmask:UInt32
    internal init(_name:String, _category_Bitmask:UInt32){
        self.name = _name
        self.category_Bitmask = _category_Bitmask
    }
}
