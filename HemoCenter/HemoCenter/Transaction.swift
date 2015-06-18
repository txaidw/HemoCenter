//
//  Transaction.swift
//  HemoCenter
//
//  Created by Albert Kolberg on 6/17/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

class Transaction {
    
    var sourceCNPJ: String?
    var destinationCNPJ: String
    var bloodType: BloodType
    var amountMl: Int
    
    init(sourceCNPJ: String?, destinationCNPJ: String, bloodType: BloodType, amountMl: Int) {
        
        self.sourceCNPJ = sourceCNPJ
        self.destinationCNPJ = destinationCNPJ
        self.bloodType = bloodType
        self.amountMl = amountMl
    }
}
