//
//  LevelPageViewController.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 27/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit
public var levelcompleted = 0

class LevelPageViewController: UIViewController {

    //set up outlet connect with the levels
    @IBOutlet weak var level1: UIButton!
    @IBOutlet weak var level2: UIButton!
    @IBOutlet weak var level3: UIButton!
    @IBOutlet weak var level4: UIButton!
    @IBOutlet weak var level5: UIButton!
    @IBOutlet weak var level6: UIButton!
    @IBOutlet weak var level7: UIButton!
    @IBOutlet weak var level8: UIButton!
    @IBOutlet weak var level9: UIButton!
    @IBOutlet weak var level10: UIButton!
    @IBOutlet weak var level11: UIButton!
    @IBOutlet weak var level12: UIButton!
    @IBOutlet weak var level13: UIButton!
    @IBOutlet weak var level14: UIButton!
    @IBOutlet weak var level15: UIButton!
    @IBOutlet weak var level16: UIButton!
    @IBOutlet weak var level17: UIButton!
    @IBOutlet weak var level18: UIButton!
    @IBOutlet weak var level19: UIButton!
    @IBOutlet weak var level20: UIButton!
    @IBOutlet weak var level21: UIButton!
    @IBOutlet weak var level22: UIButton!
    
    var Levelarray = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        appendlevel()
        if(levelcompleted<22){
            print("less than 22")
            for i in 0...levelcompleted {
                let newlevel = Levelarray[i]
                newlevel.alpha = 1
            }
        }
    }//
    
    @IBAction func LevelSelection(_ sender: UIButton) {
        performSegue(withIdentifier: "LevelSelection", sender: self)
        let levelplayed = "Level\(sender.tag)"
        scene = levelplayed
        print(scene)
    }
    
    func appendlevel(){
        Levelarray.append(level1)
        Levelarray.append(level2)
        Levelarray.append(level3)
        Levelarray.append(level4)
        Levelarray.append(level5)
        Levelarray.append(level6)
        Levelarray.append(level7)
        Levelarray.append(level8)
        Levelarray.append(level9)
        Levelarray.append(level10)
        Levelarray.append(level11)
        Levelarray.append(level12)
        Levelarray.append(level13)
        Levelarray.append(level14)
        Levelarray.append(level15)
        Levelarray.append(level16)
        Levelarray.append(level17)
        Levelarray.append(level18)
        Levelarray.append(level19)
        Levelarray.append(level20)
        Levelarray.append(level21)
        Levelarray.append(level22)
    }
   
}
