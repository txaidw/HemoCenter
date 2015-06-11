//
//  StatusViewController.swift
//  
//
//  Created by Txai Wieser on 6/11/15.
//
//

import UIKit

class StatusViewController: UIViewController {
    var networkingClosure:(((success: Bool, message: String) -> ())->())?
    
    @IBOutlet weak var messageLogLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        delay(0.8) {
            networkingClosure?{ [weak self] (success, message) -> () in
                if success {
                    self?.messageLogLabel.text = message
                } else {
                    self?.messageLogLabel.text = message
                    AppDelegate.$.userKeychainToken = nil
                }
                
                self?.activityIndicator.alpha = 0.0
                self?.messageLogLabel.alpha = 1.0
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
