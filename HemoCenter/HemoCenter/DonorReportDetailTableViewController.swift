//
//  DonorReportDetailTableViewController.swift
//  
//
//  Created by Txai Wieser on 6/18/15.
//
//

import UIKit

class DonorReportDetailTableViewController: UITableViewController {

    var selectedDonor:Donor? {
        didSet {
//            WebServiceOperations.
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cpf: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var endereço: UILabel!
    @IBOutlet weak var telefone: UILabel!
    @IBOutlet weak var rh: UISegmentedControl!
    @IBOutlet weak var tipo: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        if let d = selectedDonor {
            name.text = d.name
            cpf.text = d.CPF
            email.text = d.email
            endereço.text = d.address
            telefone.text = String(d.phone)
            rh.selectedSegmentIndex = d.bloodType.rh()
            tipo.selectedSegmentIndex = d.bloodType.type()
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
