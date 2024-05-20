//
//  Chat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Conversation: Codable, Identifiable, Hashable {
    var id: String
    let name: String
    let image: String
    let users: [String]
    var lastMessage: Message

    init(id: String, name: String, image: String, users: [String], lastMessage: Message) {
        self.id = id
        self.name = name
        self.image = image
        self.users = users
        self.lastMessage = lastMessage 
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case users
        case lastMessage = "last_message"
    }

    init(from: Decoder) throws {
        let container = try from.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        users = try container.decode([String].self, forKey: .users)
        lastMessage = try container.decode(Message.self, forKey: .lastMessage)
    }

    func encode(to: Encoder) throws {
        var container = to.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(users, forKey: .users)
        try container.encode(lastMessage, forKey: .lastMessage)
    }  
}
