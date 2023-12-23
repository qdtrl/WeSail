//
//  Races.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 05/12/2023.
//

import Foundation

class RacesModel: ObservableObject {
    @Published var races = [Race]()
    
    @Published var mockData = [
        Race(date: Date(), results: [
            BoatsModel().mockData[0],
            BoatsModel().mockData[4],
            BoatsModel().mockData[3],
            BoatsModel().mockData[1]
        ])
    ]
}
