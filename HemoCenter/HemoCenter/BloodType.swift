//
//  BloodType.swift
//  HemoCenter
//
//  Created by Txai Wieser on 6/11/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import Foundation

enum BloodType: Int {
    case Apos = 1, Aneg, Bpos, Bneg, ABpos, ABneg, Opos, Oneg
    
    init?(type:Int, rh:Int) {
        self.init(rawValue: type*2 + (rh+1))
    }
    
    func rh() -> Int {
        return (self.rawValue-1)%2
    }
    
    func type() -> Int {
        return (self.rawValue-1)/2
    }
}