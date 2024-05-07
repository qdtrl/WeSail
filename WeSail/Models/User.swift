//
//  User.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation
import Firebase

struct User: Codable, Identifiable, Hashable {
    var id: String
    let email: String
    let firstName: String
    let lastName: String
    let description: String
    let image: String
    let followers: [User]?
    let subscribers: [User]?
    
    init(
        id: String,
        email: String,
        firstName: String,
        lastName: String,
        description: String,
        image: String,
        followers: [User]? = nil,
        subscribers: [User]? = nil
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.description = description
        self.image = image
        self.followers = followers
        self.subscribers = subscribers
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case description
        case image
        case followers
        case subscribers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.followers = try container.decodeIfPresent([User].self, forKey: .followers)
        self.subscribers = try container.decodeIfPresent([User].self, forKey: .subscribers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.image, forKey: .image)
        try container.encodeIfPresent(self.followers, forKey: .followers)
        try container.encodeIfPresent(self.subscribers, forKey: .subscribers)
    }
    
    
    var initials: String {
        return "\(firstName.first?.uppercased() ?? "")\(lastName.first?.uppercased() ?? "")"
    }
}
