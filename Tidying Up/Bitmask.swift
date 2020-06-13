//
//  Bitmask.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 13/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import Foundation
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
