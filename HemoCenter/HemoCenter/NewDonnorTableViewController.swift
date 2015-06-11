//
//  NewDonnorTableViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 05/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class NewDonnorTableViewController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var bRH: UISegmentedControl!
    @IBOutlet weak var bType: UISegmentedControl!
    @IBOutlet weak var donnations: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let token = AppDelegate.$.userKeychainToken!
        let name = self.name.text
        let address = self.address.text
        let phone = self.phone.text.toInt()!
        let email = self.mail.text
        let cpf = self.cpf.text
        let bt = BloodType(type: bType.selectedSegmentIndex, rh: bRH.selectedSegmentIndex)!
        let statusView = segue.destinationViewController as! StatusViewController
        statusView.initialMessage = "Registrando Doador"
        statusView.networkingClosure = { (closure:(success: Bool, message: String) -> ()) in
            WebServiceOperations.newDonor(token, name: name, address: address, phone: phone, email: email, CPF: cpf, bloodType: bt, completionHandler: closure)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
