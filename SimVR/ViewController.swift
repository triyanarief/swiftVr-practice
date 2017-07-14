//
//  ViewController.swift
//  SimVR
//
//  Created by Jessie Deot on 5/4/16.
//  Copyright © 2016 Jessie Deot. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginTapped(sender: AnyObject) {
        
        let usernameText = usernameField.text!
        let passwordText = passwordField.text!
        
        if ( usernameText == "" || passwordText == "" ) {
            
            let alert = UIAlertController(title: "Login Failed!", message:"Please enter a valid Username and Password", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            
        } else {
            
            Alamofire.request(.GET, "http://ec2-52-39-148-197.us-west-2.compute.amazonaws.com:3000/auth/login/?email=\(usernameText)&password=\(passwordText)")
                .responseJSON {  response in
                    switch response.result {
                    case .Success(let JSON):
                        print("Success: \(JSON)")
                        self.performSegueWithIdentifier("logged_in", sender: sender)
                        
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                        let alert = UIAlertController(title: "Login Failed!", message:"Please enter a valid Username and Password", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "OK", style: .Default) { _ in}
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true){}
                        
                    }
            }
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameField.delegate = self;
        self.passwordField.delegate = self;

        
        let myColor : UIColor = UIColor( red: 14/255, green: 61/255, blue:153/255, alpha: 1.0 )
        
        //navigationController!.navigationBar.barTintColor = UIColor.blueColor()
        
        usernameField.layer.cornerRadius = 8.0
        usernameField.layer.masksToBounds = true
        usernameField.layer.borderColor = myColor.CGColor
        usernameField.layer.borderWidth = 2.0
        
        passwordField.layer.cornerRadius = 8.0
        passwordField.layer.masksToBounds = true
        passwordField.layer.borderColor = myColor.CGColor
        passwordField.layer.borderWidth = 2.0
        
        loginBtn.layer.borderColor = myColor.CGColor
        loginBtn.layer.borderWidth = 2.0 
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.backgroundColor = myColor.CGColor
        
        
    
        
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

