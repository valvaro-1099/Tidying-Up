//
//  Level.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 10/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import Foundation

class level {
    var level: Int //e.g level1,level2
    var time: Int   //time need to pass the stage
    var objective1: Bool
    var objective2: Bool
    var objective3: Bool
    var onestar: Int //time need to get 1 star
    var twostar: Int   //time need to get 2 star
    var threestar: Int //time need to get 3 star
    var itemsneedtobecleanup: Int
    
    internal init(level: Int, time:Int, objective1: Bool, objective2: Bool, objective3: Bool, onestar: Int, twostar: Int, threestar: Int , _itemneedtobecleanup: Int) {
        self.level = level
        self.objective1 = objective1
        self.objective2 = objective2
        self.objective3 = objective3
        self.onestar = onestar
        self.twostar = twostar
        self.threestar = threestar
        self.time = time
        self.itemsneedtobecleanup = _itemneedtobecleanup
    }
   
    
}
