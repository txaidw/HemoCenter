//
//  HospitalToHospitalTransactionViewController.swift
//  
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class HospitalToHospitalTransactionViewController: UITableViewController {
    
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
            } else {
                print(message)
            }
        })
    }
    
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bloodVolumeStepperValue: UIStepper!
    @IBOutlet weak var bloodVolume: UILabel!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    
    @IBOutlet weak var rh: UISegmentedControl!
    @IBOutlet weak var type: UISegmentedControl!
    
    @IBOutlet weak var log: UILabel!
    
    var leftHospital:Hospital? {
        didSet {
            if let lh = leftHospital {
                leftButton.setTitle(lh.name, forState: .Normal)
                if rightHospital != nil && bloodVolumeStepperValue.value > 0 {
                    save.enabled = true
                } else {
                    save.enabled = false
                }
            }
        }
    }
    
    var rightHospital:Hospital? {
        didSet {
            if let rh = rightHospital {
                rightButton.setTitle(rh.name, forState: .Normal)
                if leftHospital != nil && bloodVolumeStepperValue.value > 0 {
                    save.enabled = true
                } else {
                    save.enabled = false
                }
            }
        }
    }
    
    
    @IBAction func bloodVolumeStepper(sender: UIStepper) {
        bloodVolume.text = String(stringInterpolationSegment: sender.value)
        if leftHospital != nil && rightHospital != nil && sender.value > 0 {
            save.enabled = true
        } else {
            save.enabled = false
        }
    }
    
    @IBAction func directionButton(sender: UIButton) {
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
        else if let dest = segue.destinationViewController as? StatusViewController {
            var from:Hospital = leftHospital!
            var to:Hospital = rightHospital!
            if directionButton.selected {
                from = rightHospital!
                to = leftHospital!
            }
            let bt = BloodType(type: type.selectedSegmentIndex, rh: rh.selectedSegmentIndex)!
            
            let transaction = Transaction(sourceCNPJ: from.CNPJ, destinationCNPJ: to.CNPJ, bloodType: bt, amountMl: Int(bloodVolumeStepperValue.value))
            let token = AppDelegate.$.userKeychainToken!
            dest.initialMessage = "Registrando Transação"
            dest.networkingClosure = { (closure:(success: Bool, message: String) -> ()) in
                WebServiceOperations.newTransaction(token, transaction: transaction, completionHandler: closure)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}
