//
//  Boat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

struct Boat: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var type: String
    var number: String
    var club: String
    var image: String
    var owners: [String]
    var crew: [String]
    var images: [String]

    init(
     id: String,
     name: String,
     type: String,
     number: String,
     club: String,
     image: String,
     owners: [String],
     crew: [String],
     images: [String]
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.number = number
        self.club = club
        self.image = image
        self.owners = owners
        self.crew = crew
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
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.club = try container.decode(String.self, forKey: .club)
        self.number = try container.decode(String.self, forKey: .number)
        self.image = try container.decode(String.self, forKey: .image)
        self.owners = try container.decode([String].self, forKey: .owners)
        self.crew = try container.decode([String].self, forKey: .crew)
        self.images = try container.decode([String].self, forKey: .images)
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
        try container.encode(self.crew, forKey: .crew)
        try container.encode(self.images, forKey: .images)
    }
}
