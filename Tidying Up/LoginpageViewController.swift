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
                self.performSegue(withIdentifier: "Shop", sender: self)
            }
            else {
                let registered = UIAlertController(title: "login_failed", message: "username or password is wrong" , preferredStyle: .alert)
                self.present(registered, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                  // your code with delay
                  registered.dismiss(animated: true, completion: nil)
                    }
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
