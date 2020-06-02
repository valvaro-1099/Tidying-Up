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
    @IBOutlet weak var Emailtextfield : UITextField!
    @IBOutlet weak var PasswordTextFIeld : UITextField!
    
    let backgroundview = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func signupButton(_ sender: UIButton){
        
        let Check = check_email_password_validity()
        let ValidationAlert = Check.Alert
        if (Check.Validity == true)
        {
            if(Check_if_email_is_already_registered())
            {
                Createuser()
            }
            else
            {
                let Registered = UIAlertController(title: "Email has already been registered", message: "The email is already registered to another user" , preferredStyle: .alert)
                Registered.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                //Display the alert about something with the validation of user input
                self.present(Registered, animated: true, completion: nil)
                
            }


        }
        else
        {
            ValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ValidationAlert, animated: true, completion: nil)
       
        }
        
        
   
    }
    func Createuser()
    {
        Auth.auth().createUser(withEmail: Emailtextfield.text!, password: PasswordTextFIeld.text!,completion: { (user , error) in
                          if error == nil {
                              //registration successful
                           self.performSegue(withIdentifier: "gotologinpage", sender: self)
                          }else
                          {
                              //registration failure
                           let Register_fail_alert = UIAlertController(title: "Registered failed", message: "Something went wrong Registered failed" , preferredStyle: .alert)
                           self.present(Register_fail_alert, animated: true, completion: nil)
                               //dimiss the after alert after 1 second
                           let when = DispatchTime.now() + 1
                           DispatchQueue.main.asyncAfter(deadline: when)
                           {
                                       Register_fail_alert.dismiss(animated: true, completion: nil)
                           }
                          }
                       })// create user
    }
    
    func check_email_password_validity() -> (Validity:Bool, Alert:UIAlertController) {
        
        var validity:Bool = false
        var Alert:UIAlertController = UIAlertController()
        let Email = Emailtextfield.text
        let Password = PasswordTextFIeld.text
            //check if the password and emailfield is not null
        if(Emailtextfield.text != nil || PasswordTextFIeld.text != nil)
        {
            let decimalRange = Password!.rangeOfCharacter(from: CharacterSet.decimalDigits)
            let capitalLetterRegEx  = ".*[A-Z]+.*"
            let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
                //check if the email is valid
            if (Email!.contains("@") && Email!.contains(".com"))
            {
                    //check if password length is more than 10, have at leat 1 uppercase and 1 numeric character
                if(Password!.count > 6 && decimalRange == nil && texttest.evaluate(with: Password))
                { validity = true }
                else
                {
                    validity = false
                    Alert = UIAlertController(title: "Password not valid", message: "Your password must be more than 8 characters long, should contain at-least 1 Uppercase and 1 Numeric character" , preferredStyle: .alert)
                }//password_not_valid
            }
            else
            {
                validity = false
                Alert = UIAlertController(title: "Email not valid", message: "email is not valid" , preferredStyle: .alert)
            }//email_check
        }
        else
        {
            validity = false
            Alert = UIAlertController(title: "Email and Password field cannot be empty", message: "Cannot leave email or password blank" , preferredStyle: .alert)
        }//notNill_check
        return(validity,Alert)
        
       
    }
    
//  Check if the email is already registered into another email
//    func check_if_email_registered() -> Bool {
//        var registered:Bool = true
//                Auth.auth().fetchSignInMethods(forEmail: Usernametextfield.text! , completion: {
//                    (providers, error) in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    }
//                    else if let providers = providers
//                    {
//                        print(providers)
//        //              if the provider comes back with password, this means that there is a user with this email and password
//                        if (providers == ["password"])
//                        {

//                                }
//                            return registered = true
//                        }else{return registered = false}
//
//                    }
//                })
//
//
//    }
    func Check_if_email_is_already_registered() -> Bool
    {
        var validity:Bool = false
        Auth.auth().fetchSignInMethods(forEmail: Emailtextfield.text! , completion: {
                            (providers, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            else if let providers = providers
                            {
                                    //if the provider comes back with password, this means that there is a user with this email and password
                                if (providers == ["password"])
                                {
                                    validity = true
                                }
                                else
                                {validity = false}
        
                            }
                        })
        return validity
    }

}
//Auth.auth().createUser(withEmail: Emailtextfield.text!, password: PasswordTextFIeld.text!,completion: { (user , error) in
//   if error == nil {
//       //registration successful
//    self.performSegue(withIdentifier: "gotologinpage", sender: self)
//   }else
//   {
//       //registration failure
//    let Register_fail_alert = UIAlertController(title: "Registered failed", message: "Something went wrong Registered failed" , preferredStyle: .alert)
//    self.present(Register_fail_alert, animated: true, completion: nil)
//        //dimiss the after alert after 1 second
//    let when = DispatchTime.now() + 1
//    DispatchQueue.main.asyncAfter(deadline: when)
//    {
//                Register_fail_alert.dismiss(animated: true, completion: nil)
//    }
//   }
//})// create user

//// to make the alert only last 5 minutes
////dimiss the after alert after 1 second
//   let when = DispatchTime.now() + 5
//   DispatchQueue.main.asyncAfter(deadline: when)
//   {
//       ValidationAlert.dismiss(animated: true, completion: nil)
//   }
