//
//  Donor.swift
//  HemoCenter
//
//  Created by Albert Kolberg on 6/17/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

class Donor: NSObject {

    var CPF: String
    var name: String
    var email: String
    var bloodType: BloodType
    var phone: String
    var address: String
    
    init(CPF: String, name: String, email: String, bloodType: BloodType, phone: String, address: String) {
        self.CPF = CPF
        self.name = name
        self.email = email
        self.bloodType = bloodType
        self.phone = phone
        self.address = address
    }
}
