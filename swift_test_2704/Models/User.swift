//
//  User.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation

struct User: Codable {
    var id, firstName, lastName: String
    var dob, email: String?
    var phoneNumber: String?
}
