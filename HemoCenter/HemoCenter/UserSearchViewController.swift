//
//  UserSearchViewController.swift
//  
//
//  Created by Txai Wieser on 6/11/15.
//
//

import UIKit

protocol SearchPopoverDelegate:class {
    func returnedPopoverSelection(index:Int)
}

class UserSearchViewController: UITableViewController, UISearchResultsUpdating {
    var tableData:[Donor] = {
        let a = Donor(CPF: "123", name: "teste 1", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: 123, address: "132")
        let b = Donor(CPF: "456", name: "teste 2", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: 123, address: "132")
        let c = Donor(CPF: "789", name: "teste 3", email: "", bloodType: BloodType(type: 0, rh: 0)!, phone: 123, address: "132")
        
        let example = [a, b, c]
        return example
    }()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    weak var delegate:SearchPopoverDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.returnedPopoverSelection(indexPath.row)
        self.dismissViewControllerAnimated(true, completion: nil)
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
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
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
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
}