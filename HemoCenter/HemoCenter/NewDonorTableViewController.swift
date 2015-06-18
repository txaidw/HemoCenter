//
//  NewDonnorTableViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 05/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class NewDonorTableViewController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var bRH: UISegmentedControl!
    @IBOutlet weak var bType: UISegmentedControl!
    
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
        let phone = self.phone.text
        let email = self.mail.text
        var cpf = String(self.cpf.text)
        let bt = BloodType(type: bType.selectedSegmentIndex, rh: bRH.selectedSegmentIndex)!
        let statusView = segue.destinationViewController as! StatusViewController
        let donor = Donor(CPF: cpf, name: name, email: email, bloodType: bt, phone: phone, address: address)
        statusView.initialMessage = "Registrando Doador"
        statusView.networkingClosure = { (closure:(success: Bool, message: String) -> ()) in
            WebServiceOperations.newDonor(token, donor: donor, completionHandler: closure)
        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var choosedFilter:String? = nil
       
        if textField == cpf {
            choosedFilter = "###.###.###-##"
        } else if textField == phone {
            choosedFilter = "(##) ####-####"
        }
        
        if let filter = choosedFilter {
            
            var changedString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            let c1 = range.length == 1 // Only do for single deletes
            let c2 = (string as NSString).length < range.length
            let c3 = ((textField.text as NSString).substringWithRange(range) as NSString).rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "0123456789")).location == NSNotFound

            if c1 && c2 && c3 {
                // Something was deleted.  Delete past the previous number
                var location:Int = (changedString as NSString).length-1
                if location > 0 {
                    for(; location > 0; location--) {
                        let s = (changedString as NSString)
                        let j = s.characterAtIndex(location)
                        let v:Int32 = Int32(j)
                        if NSString.isDigit(j) {
                            break
                        }
                    }
                    changedString = (changedString as NSString).substringToIndex(location)
                }
            }
            
            textField.text = NSString.filteredPhoneStringFromString(changedString, withFilter: filter)
            
            return false
        }
        else
        {
            return true
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
