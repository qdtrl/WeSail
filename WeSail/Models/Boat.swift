//
//  Boat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

struct Boat: Decodable, Identifiable, Hashable {
    static func == (lhs: Boat, rhs: Boat) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    let boatId: String
    let name: String
    let type: String
    let number: Int
    let image: String
    let crew: [User]
    var events: [Event]
}
