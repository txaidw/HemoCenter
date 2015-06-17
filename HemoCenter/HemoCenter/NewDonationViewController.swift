//
//  NewDonationTableViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 06/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class NewDonationViewController: UIViewController, SearchPopoverDelegate {
    
    var donors:[Donor]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func DonorButtonAction(sender: UIButton) {
        sender.enabled = false
        
        WebServiceOperations.getAllDonors(AppDelegate.$.userKeychainToken!, completionHandler: { (success, message, donors) -> Void in
            if success {
                self.performSegueWithIdentifier("DonorButtonSegue", sender: donors)
                self.donors = donors
            } else {
                // Warning
            }
        })
    }
    
    func returnedPopoverSelection(index: Int) {
        print(donors![index].name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let donors = sender as? [Donor], let destination = segue.destinationViewController as? UserSearchViewController {
            destination.tableData = donors
            destination.delegate = self
        }
    }
    
}
