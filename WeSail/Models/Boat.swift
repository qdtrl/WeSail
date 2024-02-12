//
//  Boat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

struct Boat: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let type: String
    let number: Int
    let club: String
    let image: String
    let owners: [User]
    let crew: [User]?
    let events: [Event]?
    let images: [String]?

    init(
     id: String,
     name: String,
     type: String,
     number: Int,
     club: String,
     image: String,
     owners: [User],
     crew: [User]? = nil,
     events: [Event]? = nil,
     images: [String]? = nil
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.number = number
        self.club = club
        self.image = image
        self.owners = owners
        self.crew = crew
        self.events = events
        self.images = images
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case number
        case club
        case image
        case owners
        case crew
        case events
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.club = try container.decode(String.self, forKey: .club)
        self.number = try container.decode(Int.self, forKey: .number)
        self.image = try container.decode(String.self, forKey: .image)
        self.owners = try container.decode([User].self, forKey: .owners)
        self.crew = try container.decodeIfPresent([User].self, forKey: .crew)
        self.events = try container.decodeIfPresent([Event].self, forKey: .events)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.club, forKey: .club)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.number, forKey: .number)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.owners, forKey: .owners)
        try container.encodeIfPresent(self.crew, forKey: .crew)
        try container.encodeIfPresent(self.events, forKey: .events)
        try container.encodeIfPresent(self.images, forKey: .images)
    }
    
}
