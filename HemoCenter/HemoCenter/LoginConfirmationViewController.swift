//
//  LoginViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 02/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

protocol LoginConfirmationProtocol:class {
    var currentUserAuthentication:User? { get set }
}

class LoginConfirmationViewController: UIViewController {
    
    @IBOutlet weak var messageLogLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate:LoginConfirmationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.addTarget(self, action: Selector("loginButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonAction() {
        let user = ""
        let password = ""
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1.0
        loginButton.alpha = 0.0
        messageLogLabel.alpha = 0.0
                
        WebServiceOperations.login(user, password: password) { [weak self] (success, message, authKey, user) -> Void in
            delay(0.8) {
                if success {
                    self?.messageLogLabel.text = message
                    self?.delegate?.currentUserAuthentication = user
                    delay(0.4) {
                        self?.dismissViewControllerAnimated(true, completion: { () -> Void in
                            self?.loginButtonAction()
                        })
                    }
                } else {
                    self?.messageLogLabel.text = message
                    AppDelegate.$.userKeychainToken = nil
                }
                
                self?.activityIndicator.alpha = 0.0
                self?.loginButton.alpha = 1.0
                self?.messageLogLabel.alpha = 1.0
            }
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
