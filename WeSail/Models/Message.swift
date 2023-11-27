//
//  Message.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Message: Decodable, Identifiable {
    var id = UUID()
    let userUid: String
    let text: String
    let date: Date
    let isRead: Bool
    let userImage: String
}
