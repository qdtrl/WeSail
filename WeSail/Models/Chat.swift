//
//  Chat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Chat: Decodable, Identifiable {
    var id = UUID()
    let chatId: String
    let name: String
    let image: String
    let users: [User]
    var messages: [Message]
}
