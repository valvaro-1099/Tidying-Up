//
//  LevelInsideViewContoller.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 12/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit

class LevelInsideViewController: UIViewController {
    @IBOutlet weak var Character: UIImageView!
    let DLL = DoublyLinkedList<UIImage>()
    var currentpositon = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //create a linked list and append all the user character in it
        DLL.append(value: UIImage.init(named: "CTIdle (1)")!)
        DLL.append(value: UIImage.init(named: "Idle__000")!)
        DLL.append(value: UIImage.init(named: "zgAttack (1)")!)
        Character.image = DLL.head?.value
        
    }
    
    @IBAction func NextCharacter(_ sender: UIButton) {
        //if current positon is not more than linkedlist length
        //that means there is a more node
        if(currentpositon < DLL.count && currentpositon != DLL.count){
            currentpositon+=1
            Character.image = DLL.GetIndex(atIndex: currentpositon).value
        }
        else    //no more node
        {
            return
        }
    }
    
    @IBAction func PreviousCharacter(_ sender: UIButton)
    {
        //if current positon is not more than linkedlist length
        //that means there is a more node previous
        if(currentpositon <= DLL.count && currentpositon != 0){
            currentpositon-=1
            Character.image = DLL.GetIndex(atIndex: currentpositon).value
        }
        else    //no more node
        {
            return
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        levelcompleted+=1
    }
    

    @IBAction func PlayLevel(_ sender: Any) {
        performSegue(withIdentifier: "ToGameScene", sender: self)
        
    }
    
}
