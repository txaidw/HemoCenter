//
//  HospitalToHospitalTransactionViewController.swift
//
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class HemocenterToHospitalTransactionViewController: UITableViewController {
    
    var hospitals:[Hospital]?
    
    override func viewDidLoad() {
        let token = AppDelegate.$.userKeychainToken!
        
        WebServiceOperations.getAllHospitals(token, completionHandler: { [weak self] (success, message, hospitals) -> Void in
            if success {
                self?.hospitals = hospitals
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
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bloodVolumeStepperValue: UIStepper!
    @IBOutlet weak var bloodVolume: UILabel!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    
    @IBOutlet weak var rh: UISegmentedControl!
    @IBOutlet weak var type: UISegmentedControl!
    
    @IBOutlet weak var log: UILabel!
    
    var leftHemocenter:Hemocenter? = AppDelegate.$.hemocenter
    
    var rightHospital:Hospital? {
        didSet {
            if let rh = rightHospital {
                rightButton.setTitle(rh.name, forState: .Normal)
                if bloodVolumeStepperValue.value > 0 {
                    save.enabled = true
                } else {
                    save.enabled = false
                }
            }
        }
    }
    
    
    @IBAction func bloodVolumeStepper(sender: UIStepper) {
        bloodVolume.text = String(stringInterpolationSegment: sender.value)
        if rightHospital != nil && sender.value > 0 {
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
            if segue.identifier == "RightHospitalSegue" {
                dest.action = { [weak self] (answer:Hospital?) -> () in
                    self?.rightHospital = answer
                }
            }
        }
        else if let dest = segue.destinationViewController as? StatusViewController {
            var from:Instituition = leftHemocenter!
            var to:Instituition = rightHospital!
            if directionButton.selected {
                from = rightHospital!
                to = leftHemocenter!
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
