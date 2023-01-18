//
//  ViewController.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        email.text = ""
        password.text = ""
        
   
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityAPI.postSession(username: email.text!, password: password.text! ,completionHandler: handleLoginResponse(success:error:))
        
    }
    
    @IBAction func singUpTapped(_ sender: Any) {
        let url = URL(string: "https://auth.udacity.com/sign-up")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    
    func handleLoginResponse(success: Bool, error: Error?){
        setLoggingIn(false)
        if success{
            performSegue(withIdentifier: "completeLogin", sender: nil)
        }else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
        
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        email.isEnabled = !loggingIn
        password.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        singupButton.isEnabled = !loggingIn
    }


}




