//
//  Boats.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation	
import UIKit

class BoatsViewModel: ObservableObject {
    var repository:BoatRepositoryProtocol
    var boats: [Boat] = []
    @Published var boatsUserInCrew: [Boat] = []
    @Published var boatsSearched: [Boat] = []
    @Published var isLoading:Bool = false

    init() {
        self.repository = BoatRepository()
    }
    
    func index() {
        Task { @MainActor in
            self.isLoading = true

            self.boats = try await self.repository.index()

            self.boatsSearched = self.boats

            self.isLoading = false
        }
    }

    func indexWhereUserInCrew(userId: String) {
        Task { @MainActor in
            self.isLoading = true
            
            self.boats = try await self.repository.index()

            self.boatsUserInCrew = self.boats.filter { boat in
                boat.crew.contains(userId)
            }
            
            self.isLoading = false
        }
    }


    func search(query: String) {
        Task { @MainActor in
            self.isLoading = true

            if query != "" {
                self.boatsSearched = self.boats.filter { boat in
                    boat.name.lowercased().contains(query.lowercased())
                }
            } else {
                self.boatsSearched = self.boats
            }

            self.isLoading = false
        }
    }

    func create(_ boat: Boat, _ image: UIImage) {
        Task { @MainActor in
            self.isLoading = true

            try await self.repository.create(boat: boat, image: image) {
                boatCreated in
                DispatchQueue.main.async {
                    self.boatsUserInCrew.append(boatCreated)
                }
            }
                
            self.isLoading = false
        }
    }


    @Published var mockData = [
        Boat(
            id: "1", name: "Les Rapetous", type: "Class 10", number: "32134", club: "Yacht Club Granville", image: "https://media.bateaux.com/src/applications/showroom/images/images-produit/9f1b891f23143ede30ee690bfead2b42.png", owners: [UserViewModel().mockData[0].id], crew: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[3].id,
                UserViewModel().mockData[4].id,
                UserViewModel().mockData[5].id
            ],
            images: []
        ),
            Boat(id: "2", name: "Les Rapetous", type: "Muscadet", number: "30034", club: "Yacht Club Granville", image: "https://media01.adonnante.com/media/2016/06/monotype-national-muscadet-2016-pierrick-contin-1281-1168x750.jpg", owners: [UserViewModel().mockData[0].id], crew: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[3].id,
            ],
            images: []
        ),
            Boat(id: "3", name: "L'EPAD", type: "Tracteur", number: "32114", club: "Yacht Club Granville", image: "https://www.boat-specs.com/img/boat/199/jeanneau-sun-fast-3200-ext-2.jpg", owners: [UserViewModel().mockData[0].id], crew: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[3].id,
                UserViewModel().mockData[4].id,
                UserViewModel().mockData[5].id
            ],
            images: []
        ),
            Boat(id: "4", name: "Manche Evidence", type: "Class 40", number: "33323", club: "Yacht Club Granville", image: "https://www.manche.fr/wp-content/uploads/2023/03/manche-sport-evidence-nautique-cd50-ddaguier-04.jpg", owners: [UserViewModel().mockData[0].id], crew: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
            ],
            images: []
        ),
            Boat(id: "5", name: "Calisto", type: "SunFast 3200", number: "32222", club: "Yacht Club Granville", image: "https://www.yachts.co/wp-content/gallery/jeanneau-sun-fast-3200-r2/Jeanneau-Sun-Fast-3200-R2-Exterior-Network-Yachts14.JPG", owners: [UserViewModel().mockData[0].id], crew: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[3].id,
                UserViewModel().mockData[4].id,
                UserViewModel().mockData[5].id
            ], 
            images: []
        ),
    ]
    
    
}
