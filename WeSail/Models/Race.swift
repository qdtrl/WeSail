//
//  Race.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 05/12/2023.
//

import Foundation

struct Race: Codable, Identifiable, Hashable {
    let id: String
    let date: Date
    let results: [Boat]?
    
    init(
        id: String,
        date: Date,
        results: [Boat]? = nil
    ) {
        self.id = id
        self.date = date
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.results = try container.decode([Boat].self, forKey: .results)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case date
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.results, forKey: .results)
    }
}
