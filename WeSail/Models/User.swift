//
//  User.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct User: Decodable, Identifiable {
    var id = UUID()
    let userId: String
    let email: String
    let firstName: String
    let lastName: String
}

