//
//  DonorReportViewController.swift
//
//
//  Created by Txai Wieser on 6/11/15.
//
//

import UIKit

class DonorReportTableViewController: UITableViewController, UISearchResultsUpdating {
    var tableData:[Donor] = []
//        {
//        let a = Donor(CPF: "123", name: "teste 1", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: "123", address: "132")
//        let b = Donor(CPF: "456", name: "teste 2", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: "123", address: "132")
//        let c = Donor(CPF: "789", name: "teste 3", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: "123", address: "132")
//        
//        let example = [a, b, c]
//        return example
//        }()
    var filteredTableData = [Donor]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        let token = AppDelegate.$.userKeychainToken!

        WebServiceOperations.getAllDonors(token, completionHandler: { [weak self] (success, message, donors) -> Void in
            if success {
                self?.tableData = donors!
                self?.tableView.reloadData()
            }
        })
    }

    
    @IBAction func sangueBomSegmentedControl(sender: UISegmentedControl) {
        let token = AppDelegate.$.userKeychainToken!
        if sender.selectedSegmentIndex == 0 {
            WebServiceOperations.getAllDonors(token, completionHandler: { [weak self] (success, message, donors) -> Void in
                if success {
                    self?.tableData = donors!
                    self?.tableView.reloadData()
                }
            })
        } else {
            WebServiceOperations.getAllSangueBomDonators(token, completionHandler: { [weak self] (success, message, donors) -> Void in
                if success {
                    self?.tableData = donors!
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let ip = tableView.indexPathForCell(sender as! UITableViewCell)
        if let dest = segue.destinationViewController as? DonorReportDetailTableViewController {
            dest.selectedDonor = tableData[ip!.row]
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return self.tableData.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // 3
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row].name
            cell.detailTextLabel?.text = filteredTableData[indexPath.row].CPF
            return cell
        } else {
            cell.textLabel?.text = tableData[indexPath.row].name
            cell.detailTextLabel?.text = tableData[indexPath.row].CPF
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchController.searchBar.text)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [Donor]
        
        self.tableView.reloadData()
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