//
//  Chat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Conversation: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let users: [User]
    var messages: [Message]?

    init(id: String, name: String, image: String, users: [User], messages: [Message]? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.users = users
        self.messages = messages
    }

    enum CodingKeys: CodingKey {
        case id, name, image, users, messages
    }

    init(from: Decoder) throws {
        let container = try from.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        users = try container.decode([User].self, forKey: .users)
        messages = try container.decodeIfPresent([Message].self, forKey: .messages)
    }

    func encode(to: Encoder) throws {
        var container = to.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(users, forKey: .users)
        try container.encode(messages, forKey: .messages)
    }  
}
