//
//  NewDonationTableViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 06/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class NewDonationViewController: UITableViewController, UserSearchPopoverDelegate, HospitalSearchPopoverDelegate {
    
    var donors:[Donor]?

    var selectedDonor:Donor? {
        didSet {
            if let d = selectedDonor {
                if qtd.text!.toInt() > 0 { save.enabled = true }
                name.text = d.name
                cpf.text = d.CPF
                email.text = d.email
                endereço.text = d.address
                telefone.text = String(d.phone)
                rh.selectedSegmentIndex = d.bloodType.rh()
                tipo.selectedSegmentIndex = d.bloodType.type()
            }
        }
    }

    
    @IBOutlet weak var destinationSelection: UISegmentedControl!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cpf: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var endereço: UILabel!
    @IBOutlet weak var telefone: UILabel!
    @IBOutlet weak var rh: UISegmentedControl!
    @IBOutlet weak var tipo: UISegmentedControl!
    @IBOutlet weak var qtd: UILabel!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    var destination:String?
    
    @IBAction func DonorButtonAction(sender: UIButton) {
        let token = AppDelegate.$.userKeychainToken!
        WebServiceOperations.getAllDonors(token, completionHandler: { (success, message, donors) -> Void in
            if success {
                self.performSegueWithIdentifier("DonorButtonSegue", sender: donors)
                self.donors = donors
            } else {
                // Warning
            }
        })
    }
    

    @IBAction func qtdStepperAction(sender: UIStepper) {
        qtd.text = String(Int(sender.value))
        
        if sender.value > 0 && selectedDonor != nil {
            save.enabled = true
        } else {
            save.enabled = false
        }
    }
    
    func userSearchReturnedPopoverSelection(index: Int) {
        selectedDonor = donors![index]
    }
    func hospitalSearchReturnedPopoverSelection(hospital: Hospital, index: Int) {
        destination = hospital.CNPJ
        destinationSelection.setTitle(hospital.name, forSegmentAtIndex: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HospitalHemocenterSelection(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let token = AppDelegate.$.userKeychainToken!
            WebServiceOperations.getAllHospitals(token, completionHandler: { (success, message, hospitals) -> Void in
                if success {
                    self.performSegueWithIdentifier("ChooseHospitalSegue", sender: hospitals)
                } else {
                    // Warning
                }
            })
        } else {
            sender.setTitle("Hospital", forSegmentAtIndex: 0)
            destination = nil
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DonorButtonSegue" {
            if let donors = sender as? [Donor], let destination = segue.destinationViewController as? UserSearchViewController {
                destination.tableData = donors
                destination.delegate = self
            }
        } else if segue.identifier == "ChooseHospitalSegue" {
            if let hospitals = sender as? [Hospital], let destination = segue.destinationViewController as? HospitalSearchViewController {
                destination.tableData = hospitals
                destination.delegate = self
            }
        } else if segue.identifier == "SaveDonationSegue" {
            let token = AppDelegate.$.userKeychainToken
            let donorID = selectedDonor!.CPF
            let donation = Donation(amountMl: (qtd.text! as NSString).integerValue, donorCPF: donorID, destinationCNPJ: self.destination)
            let statusView = segue.destinationViewController as! StatusViewController
            statusView.initialMessage = "Registrando Doação"
            statusView.networkingClosure = { (closure:(success: Bool, message: String) -> ()) in
                WebServiceOperations.newDonation(token!, donation: donation, completionHandler: closure)
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
