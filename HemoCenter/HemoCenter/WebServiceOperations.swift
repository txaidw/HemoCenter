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
    class func login(user: String, password: String, completionHandler: (success: Bool, message: String, authKey: String?, user: User?) -> Void) {
        let values = [
            "operation" : 1,
            "username" : user,
            "password" : password
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            var newUser: User?
            if parsedResponse.0 {
                if let JSON = JSON as? [String: AnyObject] {
                    var name      = JSON["name"] as! String
                    var user_type = JSON["user_type"] as! Int
                    
                    if user_type == 1 {
                        newUser = Manager(name: name, username: user, password: password, email: "não venho no JSON")
                    } else {
                        newUser = Employee(name: name, username: user, password: password, email: "não venho no JSON")
                    }
                }
            }
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2, user: newUser)
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
            "phone2" : "0",
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
                    var phone       = donor["phone1"]       as! String
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
                    var phone       = donor["phone1"]       as! String
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
    class func newUser(authKey: String, user : User, completionHandler: (success: Bool, message: String, authKey: String?) -> Void) {
        let values = [
            "operation": 10,
            "key": authKey,
            "name": user.name,
            "username": user.username,
            "password": user.password,
            "type": user.roleCode,
            "email": user.email
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            let parsedResponse = self.buildParsedResponse(JSON as? NSDictionary, connectionError: connectionError)
            completionHandler(success: parsedResponse.0, message: parsedResponse.1, authKey: parsedResponse.2)
        })
    }
    
    // MARK: 11: Litar todas doações
    class func getAllDonations(authKey: String, completionHandler: (success: Bool, message: String, donations: [Donation]?) -> Void) {
        let values = [
            "operation": 11,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var donations: [Donation]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                
                message = "Sucesso ao listar doações."
                success = true
                donations = [Donation]()
                
                for donation in JSON {
                    var id          = donation["id"] as! Int
                    var CPF         = donation["cpf_giver"] as! String
                    var name        = donation["name"] as! String
                    var amountMl    = donation["qnt_blood"] as! Int
                    var CNPJ        = donation["cnpj_institute"] as! String
                    
                    let newDon = Donation(amountMl: amountMl, donorCPF: CPF, destinationCNPJ: CNPJ)
                    newDon.name = name
                    donations!.append(newDon)
                }
            }
            completionHandler(success: success, message: message, donations: donations)
        })
    }

    // MARK: 12: Listar transações
    class func getAllTransactions(authKey: String, completionHandler: (success: Bool, message: String, transactions: [Transaction]?) -> Void) {
        let values = [
            "operation": 12,
            "key": authKey
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var transactions: [Transaction]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                
                message = "Sucesso ao listar transações."
                success = true
                transactions = [Transaction]()
                
                for transaction in JSON {
                    var CNPJS       = transaction["cnpj_source"] as! String
                    var CNPJD       = transaction["cnpj_destination"] as! String
                    var bloodType   = transaction["blood_type"] as! Int
                    var amountMl    = transaction["qnt_blood"] as! Int
                    var name        = transaction["responsable_name"] as! String
                    var username    = transaction["responsable_username"] as! String
                    
                    let newTrans = Transaction(sourceCNPJ: CNPJS, destinationCNPJ: CNPJD, bloodType: BloodType(rawValue: bloodType)!, amountMl: amountMl)
                    newTrans.name = name
                    newTrans.username = username
                    
                    transactions!.append(newTrans)
                }
            }
            completionHandler(success: success, message: message, transactions: transactions)
        })
    }
    
    // MARK: 13: Listar estoque
    class func getStock(authKey: String, CNPJ: String, completionHandler: (success: Bool, message: String, stock: Stock?) -> Void) {
        let values = [
            "operation": 13,
            "key": authKey,
            "cnpj": CNPJ
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var stock: Stock?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [String: AnyObject] {
                message = "Sucesso ao listar o stock."
                success = true
                var A_pos = JSON["A_pos"] as! Int
                var A_neg = JSON["A_neg"] as! Int
                var B_pos = JSON["B_pos"] as! Int
                var B_neg = JSON["B_neg"] as! Int
                var AB_pos = JSON["AB_pos"] as! Int
                var AB_neg = JSON["AB_neg"] as! Int
                var O_pos = JSON["O_pos"] as! Int
                var O_neg = JSON["O_neg"] as! Int
                var cnpj_institute = JSON["cnpj_institute"] as! String
                var name = JSON["name"] as! String
                stock = Stock(instituitionCNPJ: cnpj_institute, instituitionName: name, aPos: A_pos, aNeg: A_neg, bPos: B_pos, bNeg: B_neg, abPos: AB_pos, abNeg: AB_neg, oPos: O_pos, oNeg: O_neg)
            }
            completionHandler(success: success, message: message, stock: stock)
        })
    }
    
    // MARK: 14: 14: Listar doações de doador
    class func getAllDonationsFromDonor(authKey: String, CPF: String, completionHandler: (success: Bool, message: String, donations: [Donation]?) -> Void) {
        let values = [
            "operation": 14,
            "key": authKey,
            "cpf": CPF
        ]
        WebServiceOperations.request(values, completionHandler: { (JSON, connectionError) -> Void in
            var message = ""
            var success = false
            var donations: [Donation]?
            if let connectionError = connectionError {
                message = "Erro de comunicação com servidor: " + connectionError.localizedDescription
                
            } else if let JSON = JSON as? [[String: AnyObject]] {
                
                message = "Sucesso ao listar doações."
                success = true
                donations = [Donation]()
                
                for donation in JSON {
                    var CPF         = donation["cpf_giver"] as! String
                    var name        = donation["name"] as! String
                    var amountMl    = donation["qnt_blood"] as! Int
                    var CNPJ        = donation["cnpj_institute"] as! String
                    var destName    = donation["institute_name"] as! String
                    var date        = donation["donation_date"] as! String
                    
                    let newDon = Donation(amountMl: amountMl, donorCPF: CPF, destinationCNPJ: CNPJ)
                    newDon.name = name
                    newDon.destinationName = destName
                    newDon.date = date
                    
                    donations!.append(newDon)
                }
            }
            completionHandler(success: success, message: message, donations: donations)
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