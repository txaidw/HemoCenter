//
//  LoginViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 02/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageLogLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasHided:"), name:UIKeyboardWillHideNotification, object: nil);
        
        self.loginButton.addTarget(self, action: Selector("loginButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonAction() {
        activityIndicator.alpha = 1.0
        loginButton.alpha = 0.0
        messageLogLabel.alpha = 0.0

        let user = userTextField.text
        let password = passwordTextField.text
        
        WebServiceOperations.login(user, password: password) { [weak self] (success, message, authKey) -> Void in
            if success {
                self?.performSegueWithIdentifier("loginSuccessful", sender: self)
                self?.messageLogLabel.text = message
            } else {
                self?.messageLogLabel.text = message
            }
            self?.activityIndicator.alpha = 0.0
            self?.loginButton.alpha = 1.0
            self?.messageLogLabel.alpha = 1.0
        }
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWasHided(notification: NSNotification) {
        var info = notification.userInfo!
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.bottomConstraint.constant = 100
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if nextTag == 4 {
            self.loginButtonAction()
            textField.resignFirstResponder()
        } else {
            let nextResponder = textField.superview?.viewWithTag(nextTag)
            if let nr = nextResponder {
                nr.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return false // We do not want UITextField to insert line-breaks.
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
