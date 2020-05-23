//
//  LoginpageViewController.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 22/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit

class LoginpageViewController: UIViewController {
    let backgroundview = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadbackground()

      
    }
    
    //    load the background for loginpage
        func loadbackground(){
            view.addSubview(backgroundview)
            backgroundview.translatesAutoresizingMaskIntoConstraints = false
            backgroundview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    //        left side anchor
            backgroundview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    //        right side anchor
             backgroundview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    //        set image
            backgroundview.image = UIImage(named: "loginpage")
            view.sendSubviewToBack(backgroundview)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
