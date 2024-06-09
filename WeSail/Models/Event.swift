//
//  Event.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation
import Firebase

struct Event: Codable, Identifiable, Hashable {
    var id: String
    var boatId: String
    var name: String
    var startDate: Date
    var endDate: Date
    var createdAt: Date
    var participants: [String]    

    init(
        id: String,
        boatId: String,
        name: String,
        startDate: Date,
        endDate: Date,
        createdAt: Date,
        participants: [String]
    ) {
        self.id = id
        self.boatId = boatId
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = createdAt
        self.participants = participants
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        boatId = try container.decode(String.self, forKey: .boatId)
        name = try container.decode(String.self, forKey: .name)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        participants = try container.decode([String].self, forKey: .participants)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(boatId, forKey: .boatId)
        try container.encode(name, forKey: .name)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(participants, forKey: .participants)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case boatId
        case name
        case startDate
        case endDate
        case createdAt
        case participants
    }

    var dictionaryValue: [String: Any] {
        return [
            "id": id,
            "boat_id": boatId,
            "name": name,
            "start_date": startDate,
            "end_date": endDate,
            "created_at": createdAt,
            "participants": participants
        ]
    }
}
