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
    
    init(id: String, user: User, text: String, date: Date, isRead: Bool) {
        self.id = id
        self.user = user
        self.text = text
        self.date = date
        self.isRead = isRead
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case text
        case date
        case isRead = "is_read"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.user = try container.decode(User.self, forKey: .user)
        self.text = try container.decode(String.self, forKey: .text)
        self.date = try container.decode(Date.self, forKey: .date)
        self.isRead = try container.decode(Bool.self, forKey: .isRead)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(user, forKey: .user)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
        try container.encode(isRead, forKey: .isRead)
    }
}
