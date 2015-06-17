//
//  WebServiceOperations.swift
//  WebserviceTests
//
//  Created by Albert Kolberg on 6/9/15.
//  Copyright (c) 2015 Albert Kolberg. All rights reserved.
//

import Alamofire

class WebServiceOperations {
    
    static private let WEBSERVICE_URL = "http://ec2-52-7-220-135.compute-1.amazonaws.com/hemocentro/api/index.php"
    
    // MARK: 1: Login
    class func login(user: String, password: String, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
        let values = [
            "operation" : 1,
            "username" : user,
            "password" : password
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
        })
    }
    
    // MARK: 2: Cadastrar novo Doador
    class func newDonor(authKey: String, donor: Donor, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation" : 2,
            "key" : authKey,
            "name" : donor.name,
            "adress" : donor.address,
            "phone1" : donor.phone,
            "phone2" : 0,
            "email" : donor.email,
            "cpf" : donor.CPF,
            "blood_type" : donor.bloodType.rawValue
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
    
    // MARK: 3: Registrar doação
    class func newDonation(authKey: String, donation: Donation, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation": 3,
            "key": authKey,
            "qnt_blood": donation.amountMl,
            "cpf": donation.donorCPF,
            "cnpj": donation.destinationCNPJ ?? "null"
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
 
    // MARK: 4: Listar todos doadores
    class func getAllDonors(authKey: String, completionHandler: (success: Bool, message: String, donors: [Donor]?) -> Void) {
        let values = [
            "operation": 4,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var donors: [Donor]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                message = "Sucesso ao listar doadores."
                success = true
                donors = [Donor]()
                
                for donor in JSON {
                    var id          = donor["id"]           as! Int
                    var CPF         = donor["cpf"]          as! String
                    var name        = donor["name"]         as! String
                    var email       = donor["email"]        as! String
                    var bloodType   = donor["blood_type"]   as! Int
                    var phone       = donor["phone1"]       as! Int
                    var address     = donor["adress"]       as! String
                    donors!.append(Donor(CPF: CPF, name: name, email: email, bloodType: BloodType(rawValue: bloodType)!, phone: phone, address: address))
                }
            }
            completionHandler(success: success, message: message, donors: donors)
        })
    }
    
    // MARK: 5 : Listar todos hospitais
    class func getAllHospitals(authKey: String, completionHandler: (success: Bool, message: String, hospitals: [Hospital]?) -> Void) {
        let values = [
            "operation": 5,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var hospitals: [Hospital]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                message = "Sucesso ao listar doadores."
                success = true
                hospitals = [Hospital]()
                
                for donor in JSON {
                    var CNPJ    = donor["cnpj"] as! String
                    var name    = donor["name"] as! String
                    hospitals!.append(Hospital(CNPJ: CNPJ, name: name))
                }
            }
            completionHandler(success: success, message: message, hospitals: hospitals)
        })
    }
    
    // MARK: 6: Listar dados hemocentro
    class func hemocenterInfo(authKey: String, completionHandler: (success: Bool, message: String, hemocenter: Hemocenter?) -> Void) {
        let values = [
            "operation": 6,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var hemocenter: Hemocenter?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [String: AnyObject] {
                message = "Sucesso ao listar doadores."
                success = true
                var CNPJ    = JSON["cnpj"] as! String
                var name    = JSON["name"] as! String
                hemocenter = Hemocenter(CNPJ: CNPJ, name: name)
            }
            completionHandler(success: success, message: message, hemocenter: hemocenter)
        })
    }
    
    // MARK: 7: Listar doadores contemplados com programa “sangue bom”
    class func getAllSangueBomDonators(authKey: String, completionHandler: (success: Bool, message: String, donors: [Donor]?) -> Void) {
        let values = [
            "operation": 7,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var donors: [Donor]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                message = "Sucesso ao listar doadores."
                success = true
                donors = [Donor]()
                
                for donor in JSON {
                    var id          = donor["id"]           as! Int
                    var CPF         = donor["cpf"]          as! String
                    var name        = donor["name"]         as! String
                    var email       = donor["email"]        as! String
                    var bloodType   = donor["blood_type"]   as! Int
                    var phone       = donor["phone1"]       as! Int
                    var address     = donor["adress"]       as! String
                    donors!.append(Donor(CPF: CPF, name: name, email: email, bloodType: BloodType(rawValue: bloodType)!, phone: phone, address: address))
                }
            }
            completionHandler(success: success, message: message, donors: donors)
        })
    }
    
    // MARK: 8: Cadastrar novo hospital
    class func newHospital(authKey: String, hospital: Hospital, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation": 8,
            "key": authKey,
            "name": hospital.name,
            "cnpj": hospital.CNPJ
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
    
    // MARK: 9: Realizar transação
    class func newTransaction(authKey: String, transaction: Transaction, completionHandler: (success: Bool, message: String) -> Void) {
        let values = [
            "operation": 9,
            "key": authKey,
            "cnpj_source": transaction.sourceCNPJ ?? "null",
            "cnpj_destination": transaction.destinationCNPJ,
            "qnt_blood": transaction.amountMl,
            "blood_type": transaction.bloodType.rawValue,
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
        })
    }
    
    // MARK: 10: Cadastrar usuário
    class func newUser <U: User where U: WebServiceUser> (authKey: String, user : U, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
        let values = [
            "operation": 10,
            "key": authKey,
            "name": user.name,
            "username": user.username,
            "password": user.password,
            "type": user.roleCode(),
            "email": user.email
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
        })
    }
    
    // MARK: Private Methods
    
    private class func request(JSONObject: AnyObject, completionHandler: (AnyObject?, NSError?) -> Void) {
        let url = NSURL(string: WEBSERVICE_URL)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(JSONObject, options: nil, error: &error)
        Alamofire.request(request).responseJSON(options: nil) { (_, _, JSON, error) -> Void in
            completionHandler(JSON, error)
            println("### debug JSON: ###")
            println(JSON)
        }
    }
    
    private class func buildParsedResponse(JSON: NSDictionary?, connectionError: NSError?) -> (success: Bool, message: String, authKey: String?) {
        var success = false
        var message = ""
        var authKey: String?
        if let connectionError = connectionError {
            message = "Erro de comunicação com o servidor: " + connectionError.localizedDescription
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


    // MARK: Old shit
//    class func newDonor(authKey: String, name: String, address: String, phone: Int, email: String, CPF: String, bloodType: BloodType, completionHandler: (success: Bool, message: String) -> Void) {
//        let values = [
//            "operation" : 2,
//            "key" : authKey,
//            "name" : name,
//            "adress" : address,
//            "phone1" : phone,
//            "phone2" : 0,
//            "email" : email,
//            "cpf" : CPF,
//            "blood_type" : bloodType.rawValue
//        ]
//        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
//            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
//            completionHandler(success: parsedResponse.0, message: parsedResponse.1)
//        })
//    }

//    class func newUser(authKey: String, name: String, username: String, password: String, manager: Bool, email: String, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
//        let values = [
//            "operation": 10,
//            "key": authKey,
//            "name": name,
//            "username": username,
//            "password": password,
//            "type": manager ? 1 : 2,
//            "email": email
//        ]
//        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
//            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
//            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
//        })
//    }

//class func newDonation(authKey: String, CPF: String, CNPJ: String, bloodType: BloodType, amountMl: Float, completionHandler: (success: Bool, message: String) -> Void) {
//    let values = [
//        "operation": 3,
//        "key": authKey,
//        "qnt_blood": amountMl,
//        "cpf": CPF,
//        "cnpj": CNPJ,
//        "blood_type": bloodType.rawValue
//    ]
//    WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
//        let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
//        completionHandler(success: parsedResponse.0, message: parsedResponse.1)
//    })
//}