//
//  Races.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 05/12/2023.
//

import Foundation

class RacesViewModel: ObservableObject {
    @Published var races = [Race]()
    
    @Published var mockData = [
        Race(
            id: "1",
            date: Date(), results: [
            BoatsViewModel().mockData[0],
            BoatsViewModel().mockData[4],
            BoatsViewModel().mockData[3],
            BoatsViewModel().mockData[1]
        ])
    ]
}
