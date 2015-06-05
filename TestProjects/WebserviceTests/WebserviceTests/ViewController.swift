//
//  ViewController.swift
//  WebserviceTests
//
//  Created by Albert Kolberg on 6/4/15.
//  Copyright (c) 2015 Albert Kolberg. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func postRequestTest() {
        
        let dataDict = [
            "Nome": "Alysson",
            "Sobrenome": "Pipoquero",
            "CPF": "666"
        ]
        let url = NSURL(string: "NEGROS_MARAVILHOSOS")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = dataDict
        
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

