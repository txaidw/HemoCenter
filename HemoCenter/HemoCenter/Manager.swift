//
//  Manager.swift
//  HemoCenter
//
//  Created by Albert Kolberg on 6/17/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

class Manager: User {
    
    override init(name: String, username: String, password: String, email: String) {
        super.init(name: name, username: username, password: password, email: email)
        self.roleCode = 1
    }
}
