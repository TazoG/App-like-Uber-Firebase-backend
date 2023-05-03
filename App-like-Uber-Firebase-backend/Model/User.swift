//
//  User.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 20.04.23.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let accountType: Int
    
    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
