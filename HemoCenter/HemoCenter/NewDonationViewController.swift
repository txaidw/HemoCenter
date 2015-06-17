//
//  NewDonationTableViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 06/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class NewDonationViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let token = AppDelegate.$.userKeychainToken!
//        let name = self.name.text
//        let address = self.address.text
//        let phone = self.phone.text.toInt()!
//        let email = self.mail.text
//        let cpf = self.cpf.text
//        let bt = BloodType(type: bType.selectedSegmentIndex, rh: bRH.selectedSegmentIndex)!
//        let statusView = segue.destinationViewController as! StatusViewController
//        statusView.initialMessage = "Registrando Doador"
//        statusView.networkingClosure = { (closure:(success: Bool, message: String) -> ()) in
//            WebServiceOperations.newDonor(token, name: name, address: address, phone: phone, email: email, CPF: cpf, bloodType: bt, completionHandler: closure)
//        }
    }
    
}
