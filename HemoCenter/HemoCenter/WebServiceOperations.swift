//
//  WebServiceOperations.swift
//  WebserviceTests
//
//  Created by Albert Kolberg on 6/9/15.
//  Copyright (c) 2015 Albert Kolberg. All rights reserved.
//

import Foundation
import Alamofire

enum BloodType: Int {
    case Apos = 1, Aneg, Bpos, Bneg, ABpos, ABneg, Opos, Oneg
}

class WebServiceOperations: NSObject {
    
    static private let WEBSERVICE_URL = "http://ec2-52-7-220-135.compute-1.amazonaws.com/hemocentro/api/index.php"
    
    class func login(user: String, password: String, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
        let values = [
            "operation" : 1,
            "username" : user,
            "password" : password
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
        })
    }
    
    class func newDonor(authKey: String, name: String, address: String, phone: Int, email: String, CPF: String, bloodType: BloodType, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation" : 2,
            "key" : authKey,
            "name" : name,
            "adress" : address,
            "phone1" : phone,
            "phone2" : 0,
            "email" : email,
            "cpf" : CPF,
            "blood_type" : bloodType.rawValue
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
    
    class func newDonation(authKey: String, CPF: String, CNPJ: String, bloodType: BloodType, amountMl: Float, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation": 3,
            "key": authKey,
            "qnt_blood": amountMl,
            "cpf": CPF,
            "cnpj": CNPJ,
            "blood_type": bloodType.rawValue
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
    
    class func newUser(authKey: String, name: String, username: String, password: String, manager: Bool, email: String, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
        let values = [
            "operation": 10,
            "key": authKey,
            "name": name,
            "username": username,
            "password": password,
            "type": manager ? 1 : 2,
            "email": email
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
        })
    }

    private class func request(JSONObject: AnyObject, completionHandler: (NSDictionary?, NSError?) -> Void) {
        let url = NSURL(string: WEBSERVICE_URL)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(JSONObject, options: nil, error: &error)
        Alamofire.request(request).responseJSON(options: nil) { (_, _, JSON, error) -> Void in
            completionHandler(JSON as? NSDictionary, error)
        }
    }
    
    private class func buildParsedResponse(JSON: NSDictionary?, connectionError: NSError?) -> (success: Bool, message: String, authKey: String?) {
        var success = false
        var message = ""
        var authKey: String?
        if let connectionError = connectionError {
            message = connectionError.localizedDescription
        } else if let JSON = JSON {
            if JSON.valueForKey("status") as! Int == 1 {
                success = true
                authKey = JSON.objectForKey("key") as? String
            }
            message = JSON.valueForKey("msg") as! String
        }
        return (success, message, authKey)
    }
}