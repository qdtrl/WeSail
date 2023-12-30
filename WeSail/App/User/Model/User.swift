//
//  User.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation
import Firebase

struct User: Codable, Identifiable, Hashable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let image: String?
    let boats: [Boat]?
    
    init(
     id: String,
     email: String,
     firstName: String,
     lastName: String,
     image: String? = nil,
     boats: [Boat]? = nil
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.boats = boats
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case image
        case boats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.boats = try container.decodeIfPresent([Boat].self, forKey: .boats)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.image, forKey: .image)
    }
    
    
    var initials: String {
        return "\(firstName.first?.uppercased() ?? "")\(lastName.first?.uppercased() ?? "")"
    }
}
