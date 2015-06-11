//
//  StatusViewController.swift
//  
//
//  Created by Txai Wieser on 6/11/15.
//
//

import UIKit

class StatusViewController: UIViewController {
    var networkingClosure:((closure: (success: Bool, message: String) -> Void) ->  Void)?
    var initialMessage:String?
    @IBOutlet weak var messageLogLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.messageLogLabel.text = initialMessage
        self.activityIndicator.startAnimating()
        delay(0.8) {
            self.networkingClosure? { (success, message) -> Void in
                if success {
                    self.messageLogLabel.text = message
                } else {
                    self.messageLogLabel.text = message
                    AppDelegate.$.userKeychainToken = nil
                }
                
                self.activityIndicator.alpha = 0.0
                self.messageLogLabel.alpha = 1.0
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
