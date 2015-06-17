//
//  File.swift
//  HemoCenter
//
//  Created by Txai Wieser on 6/11/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

import Foundation


func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
