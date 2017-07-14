//
//  RegisterViewController.swift
//  SimVR
//
//  Created by Jessie Deot on 5/10/16.
//  Copyright © 2016 Jessie Deot. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var verifyPasswordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self;
        self.passwordField.delegate = self;
        
        let myColor : UIColor = UIColor( red: 14/255, green: 61/255, blue:153/255, alpha: 1.0 )
        
        //navigationController!.navigationBar.barTintColor = UIColor.blueColor()
        
        emailField.layer.cornerRadius = 8.0
        emailField.layer.masksToBounds = true
        emailField.layer.borderColor = myColor.CGColor
        emailField.layer.borderWidth = 2.0
        
        passwordField.layer.cornerRadius = 8.0
        passwordField.layer.masksToBounds = true
        passwordField.layer.borderColor = myColor.CGColor
        passwordField.layer.borderWidth = 2.0
        
        verifyPasswordField.layer.cornerRadius = 8.0
        verifyPasswordField.layer.masksToBounds = true
        verifyPasswordField.layer.borderColor = myColor.CGColor
        verifyPasswordField.layer.borderWidth = 2.0
        
        registerBtn.layer.borderColor = myColor.CGColor
        registerBtn.layer.borderWidth = 2.0
        registerBtn.layer.cornerRadius = 8.0
        registerBtn.layer.backgroundColor = myColor.CGColor
        
        
    }
    
    @IBAction func RegisterBtn(sender: AnyObject) {
        
        let emailText = emailField.text!
        let passwordText = passwordField.text!
        let verifyPasswordText = verifyPasswordField.text!
        
        if ( emailText == "" || passwordText == "" || verifyPasswordText == "" ) {
            
            let alert = UIAlertController(title: "Registration Failed!", message:"Please enter the required fields", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            
        } else if (passwordText != verifyPasswordText) {
            let alert = UIAlertController(title: "Registration Failed!", message:"The passwords do not match. Try again!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            
        } else {
            
            //let params = ["email":emailText,"password":passwordText] as Dictionary<String, AnyObject>
            
            Alamofire.request(.POST, "http://ec2-52-39-148-197.us-west-2.compute.amazonaws.com:3000/auth/register", parameters:["email":emailText,"password":passwordText])
                .responseString { response in
                    let httpResponse = response.response?.statusCode
                    if(httpResponse! == 201){
                        
                            self.performSegueWithIdentifier("registered", sender: sender)
                    } else {
                        
                        let alert = UIAlertController(title: "Registration Failed!", message:"Try again", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "OK", style: .Default) { _ in}
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true){}
                        
                    }
            }
            
            
            
            
            
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

