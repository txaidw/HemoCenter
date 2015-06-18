//
//  TransactionsTableViewController.swift
//  
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class TransactionsTableViewController: UITableViewController, UISearchResultsUpdating {
    var tableData:[Transaction] = []
    var filteredTableData = [Donor]()
    var resultSearchController = UISearchController()
    
    weak var delegate:UserSearchPopoverDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = AppDelegate.$.userKeychainToken!
        
        WebServiceOperations.getAllTransactions(token, completionHandler: { [weak self] (success, message, transactions) -> Void in
            if success {
                self?.tableData = transactions!
                self?.tableView.reloadData()
            }
        })
//        
//        
//        self.resultSearchController = ({
//            let controller = UISearchController(searchResultsController: nil)
//            controller.searchResultsUpdater = self
//            controller.dimsBackgroundDuringPresentation = false
//            controller.searchBar.sizeToFit()
//            
//            self.tableView.tableHeaderView = controller.searchBar
//            
//            return controller
//        })()
//        
//        // Reload the table
//        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.userSearchReturnedPopoverSelection(indexPath.row)
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
            cell.textLabel?.text = filteredTableData[indexPath.row].name
            cell.detailTextLabel?.text = filteredTableData[indexPath.row].CPF
            return cell
        } else {
            cell.textLabel?.text = tableData[indexPath.row].sourceCNPJ
            cell.detailTextLabel?.text = tableData[indexPath.row].destinationCNPJ
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
    
}