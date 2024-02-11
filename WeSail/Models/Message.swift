//
//  Message.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Message: Codable, Identifiable, Hashable {
    var id: String
    let user: User
    let text: String
    let date: Date
    var isRead: Bool
}
