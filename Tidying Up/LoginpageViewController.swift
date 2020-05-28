//
//  LoginpageViewController.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 22/5/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginpageViewController: UIViewController {
    let backgroundview = UIImageView()
    @IBOutlet weak var UsernameTexfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


      
    }
// Check if there is user with that email and password in firebase
    @IBAction func Login(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: UsernameTexfield.text!, password: PasswordTextfield.text!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "gotosignuppage", sender: self)
            }
            else {
                print("there is an error")
            }
        }
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
