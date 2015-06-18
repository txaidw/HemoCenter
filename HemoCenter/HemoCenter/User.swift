//
//  User.swift
//  HemoCenter
//
//  Created by Albert Kolberg on 6/17/15.
//  Copyright (c) 2015 TDW. All rights reserved.
//

class User {
    
    var name: String
    var username: String
    var password: String
    var email: String
    var roleCode = 0
    
    init(name: String, username: String, password: String, email: String) {
        
        self.name = name
        self.username = username
        self.password = password
        self.email = email
    }
}
