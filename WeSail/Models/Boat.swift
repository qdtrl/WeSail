//
//  Boat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

struct Boat: Decodable, Identifiable {
    var id = UUID()
    let boatId: String
    let boatName: String
    let boatImage: String
    let crew: [User]
    var events: [Event]
}
