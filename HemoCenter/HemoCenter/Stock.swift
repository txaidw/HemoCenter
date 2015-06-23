//
//  Stock.swift
//  HemoCenter
//
//  Created by Albert Kolberg on 6/18/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

class Stock {
    var aPos: Int
    var aNeg: Int
    var bPos: Int
    var bNeg: Int
    var abPos: Int
    var abNeg: Int
    var oPos: Int
    var oNeg: Int
    var instituitionCNPJ: String
    var instituitionName: String

    init(instituitionCNPJ: String, instituitionName: String, aPos: Int, aNeg: Int, bPos: Int, bNeg: Int, abPos: Int, abNeg: Int, oPos: Int, oNeg: Int) {
        self.instituitionCNPJ = instituitionCNPJ
        self.instituitionName = instituitionName
        self.aPos = aPos
        self.aNeg = aNeg
        self.bPos = bPos
        self.bNeg = bNeg
        self.abPos = abPos
        self.abNeg = abNeg
        self.oPos = oPos
        self.oNeg = oNeg
    }
    
    func lista() -> String {
        let s = "A Positivo: \(aPos) \nA Positivo: \(aPos) \nA Negativo: \(aNeg) \nB Positivo: \(bPos) \nB Negativo: \(bNeg) \nAB Positivo: \(abPos) \nAB Negativo: \(abNeg) \nO Positivo: \(oPos)\nO Negativo: \(oNeg)"
        
        return s
    }
}
