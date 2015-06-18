//
//  HospitalToHospitalTransactionViewController.swift
//  
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class HospitalToHospitalTransactionViewController: UIViewController {
    
    var hospitals:[Hospital]?
    
    override func viewDidLoad() {
        let token = AppDelegate.$.userKeychainToken!
        
        WebServiceOperations.getAllHospitals(token, completionHandler: { [weak self] (success, message, hospitals) -> Void in
            if success {
                self?.hospitals = hospitals
                self?.leftButton.enabled = true
                self?.rightButton.enabled = true
                self?.spinner.stopAnimating()
                self?.directionButton.hidden = false
            }
        })
    }
    
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var leftHospital:Hospital? {
        didSet {
            if let lh = leftHospital {
                leftButton.setTitle(lh.name, forState: .Normal)
            }
        }
    }
    
    var rightHospital:Hospital? {
        didSet {
            if let rh = rightHospital {
                rightButton.setTitle(rh.name, forState: .Normal)
            }
        }
    }
    
    @IBAction func rightButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func leftButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func directionButton(sender: UIButton) {
        if sender.selected {
            
        } else {
            
        }
        sender.selected = !sender.selected
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? HospitalSearchViewController {
            dest.tableData = hospitals!
            if segue.identifier == "LeftHospitalSegue" {
                dest.action = { [weak self] (answer:Hospital?) -> () in
                    self?.leftHospital = answer
                }
            } else if segue.identifier == "RightHospitalSegue" {
                dest.action = { [weak self] (answer:Hospital?) -> () in
                    self?.rightHospital = answer
                }
            }
        }
    }
}
