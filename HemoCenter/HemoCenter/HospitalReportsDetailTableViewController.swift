//
//  HospitalReportsDetailTableViewController.swift
//  
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class HospitalReportsDetailTableViewController: UITableViewController {
    var selectedHospital:Hospital? {
        didSet {
//            WebServiceOperations.
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cnpj: UILabel!

    
    override func viewWillAppear(animated: Bool) {
        if let d = selectedHospital {
            name.text = d.name
            cnpj.text = d.CNPJ
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
