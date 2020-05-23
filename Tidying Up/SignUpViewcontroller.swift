//
//  SignUpViewcontroller.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 23/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewcontroller: UIViewController {
    
//    property for connecting with the storyboard UI
    @IBOutlet weak var Usernametextfield : UITextField!
    @IBOutlet weak var PasswordTextFIeld : UITextField!
    
    let backgroundview = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signupButton(_ sender: UIButton){
        Auth.auth().createUser(withEmail: Usernametextfield.text!, password: PasswordTextFIeld.text!) { (user, error) in
            if user != nil
            {
                print("user created")
//                self.performSegue(withIdentifier: "SignUpButton", sender: self)
        
            }
            else
            {
                print("error")
            }
            
        }
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
       

}
