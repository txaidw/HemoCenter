//
//  UserSearchViewController.swift
//
//
//  Created by Txai Wieser on 6/11/15.
//
//

import UIKit

protocol HospitalSearchPopoverDelegate:class {
    func hospitalSearchReturnedPopoverSelection(hospital:Hospital, index: Int)
}

class HospitalSearchViewController: UITableViewController, UISearchResultsUpdating {
    var tableData:[Hospital] = {
        let a = Hospital(CNPJ: "654.654.65", name: "Hosp1")
        let b = Hospital(CNPJ: "5641561..5", name: "Hosp2")
        let c = Hospital(CNPJ: "651.65.15.", name: "Hosp3")
        
        let example = [a, b, c]
        return example
        }()
    var filteredTableData = [Hospital]()
    var resultSearchController = UISearchController()
    
    weak var delegate:HospitalSearchPopoverDelegate?
    var action:((answer:Hospital?)->())?
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
        let d = tableData[indexPath.row]
        self.delegate?.hospitalSearchReturnedPopoverSelection(d, index: indexPath.row)
        self.action?(answer: d)
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
            cell.detailTextLabel?.text = filteredTableData[indexPath.row].CNPJ
            return cell
        } else {
            cell.textLabel?.text = tableData[indexPath.row].name
            cell.detailTextLabel?.text = tableData[indexPath.row].CNPJ
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchController.searchBar.text)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [Hospital]
        
        self.tableView.reloadData()
    }
    
}