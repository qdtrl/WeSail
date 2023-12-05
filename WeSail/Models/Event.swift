//
//  Event.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation


struct Event: Decodable, Identifiable {
    var id = UUID()
    let eventId: String
    let status: String
    let name: String
    let organizer: String
    let description: String
    let type: String
    let images: [String]
    let startDate: Date
    let endDate: Date
    let races: [Race]
}
