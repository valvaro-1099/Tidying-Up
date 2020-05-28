//
//  SignUpViewcontroller.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 23/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpViewcontroller: UIViewController {
    
//    property for connecting with the storyboard UI
    @IBOutlet weak var Usernametextfield : UITextField!
    @IBOutlet weak var PasswordTextFIeld : UITextField!
    
    let backgroundview = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
//    Sign up user to firebase
    @IBAction func signupButton(_ sender: UIButton){
        
        
        
        Auth.auth().createUser(withEmail: Usernametextfield.text!, password: PasswordTextFIeld.text!) { (user, error) in
//          check if username and password is already been type by the user
            if user != nil
            {
                let ref = Database.database().reference().child("users")

                ref.queryOrdered(byChild: "email").queryEqual(toValue: self.Usernametextfield.text!).observe(.value, with: { snapshot in
                        if snapshot.exists()
                        {

                           //User email exist
                            _ = UIAlertController(title: "emailalreadyregistered", message: "email has already been registered under another user" , preferredStyle: .alert)
                            
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "gotologinpage", sender: self)
                            
                        }

                    })
                            
        self.performSegue(withIdentifier: "gotologinpage", sender: self)
            }
            else
            {
                //User email exist
                _ = UIAlertController(title: "emailalreadyregistered", message: "email has already been registered under another user" , preferredStyle: .alert)
            
            }
            
        }//create user
    }
 
       

}
