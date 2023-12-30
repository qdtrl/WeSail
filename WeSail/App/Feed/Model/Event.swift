//
//  Event.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation
import Firebase

struct Event: Codable, Identifiable, Hashable {
    let id: String
    let status: String
    let name: String
    let organizer: String
    let description: String
    let type: String
    let images: [String]?
    let startDate: Date
    let endDate: Date
    let races: [Race]?
    let participants: [Boat]?

    init(
        id: String,
        status: String,
        name: String,
        organizer: String,
        description: String,
        type: String,
        images: [String]? = nil,
        startDate: Date,
        endDate: Date,
        races: [Race]? = nil,
        participants: [Boat]? = nil
    ) {
        self.id = id
        self.status = status
        self.name = name
        self.organizer = organizer
        self.description = description
        self.type = type
        self.images = images
        self.startDate = startDate
        self.endDate = endDate
        self.races = races
        self.participants = participants
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case name
        case organizer
        case description
        case type
        case images
        case startDate = "start_date"
        case endDate = "end_date"
        case races
        case participants
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.status = try container.decode(String.self, forKey: .status)
        self.name = try container.decode(String.self, forKey: .name)
        self.organizer = try container.decode(String.self, forKey: .organizer)
        self.description = try container.decode(String.self, forKey: .description)
        self.type = try container.decode(String.self, forKey: .type)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.races = try container.decodeIfPresent([Race].self, forKey: .races)
        self.participants = try container.decodeIfPresent([Boat].self, forKey: .participants)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.organizer, forKey: .organizer)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.images, forKey: .images)
        try container.encode(self.startDate, forKey: .startDate)
        try container.encode(self.endDate, forKey: .endDate)
        
    }
    
}
