//
//  Race.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 05/12/2023.
//

import Foundation

struct Race: Decodable, Identifiable, Hashable {
    static func == (lhs: Race, rhs: Race) -> Bool {
        lhs.id == rhs.id
    }    
    var id = UUID()
    let date: Date
    let results: [Boat]
}
