//
//  HospitalReportsViewController.swift
//  HemoCenter
//
//  Created by Txai Wieser on 06/06/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import UIKit

class HospitalReportsViewController: UITableViewController, UISearchResultsUpdating {
    
    var tableData:[Hospital] = []// {
//        let a = Hospital(CNPJ: "654.654.65", name: "Hosp1")
//        let b = Hospital(CNPJ: "5641561..5", name: "Hosp2")
//        let c = Hospital(CNPJ: "651.65.15.", name: "Hosp3")
//        
//        let example = [a, b, c]
//        return example
//        }()
    var filteredTableData = [Hospital]()
    var resultSearchController = UISearchController()
    
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        let token = AppDelegate.$.userKeychainToken!
        
        WebServiceOperations.getAllHospitals(token, completionHandler: { [weak self] (success, message, hospitals) -> Void in
            if success {
                self?.tableData = hospitals!
                self?.tableView.reloadData()
                
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let ip = tableView.indexPathForCell(sender as! UITableViewCell)
        if let dest = segue.destinationViewController as? HospitalReportsDetailTableViewController {
            dest.selectedHospital = tableData[ip!.row]
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