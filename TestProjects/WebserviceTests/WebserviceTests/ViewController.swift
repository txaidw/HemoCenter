//
//  ViewController.swift
//  WebserviceTests
//
//  Created by Albert Kolberg on 6/5/15.
//  Copyright (c) 2015 Albert Kolberg. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uploadJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func uploadJSON() {
        let url = NSURL(string: "<URL_AQUI>")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = [
            "Nome": "Alysson",
            "Sobrenome": "Pipoqueiro",
            "CPF": "123456"]
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(values, options: nil, error: &error)
        
        Alamofire.request(request).responseJSON { (request, response, responseObject, error) in
                // do whatever you want here
                
                if responseObject == nil {
                    println(error)
                } else {
                    println(responseObject)
                }
        }
    }
    
}

