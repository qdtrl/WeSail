//
//  Boats.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation

class BoatsModel: ObservableObject {
    @Published var boats = [Boat]()            
    
    @Published var mockData = [
        Boat(
            boatId: "1", name: "Les Rapetous", type: "Class 10", number: 32134, image: "https://media.bateaux.com/src/applications/showroom/images/images-produit/9f1b891f23143ede30ee690bfead2b42.png", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
                UserModel().mockData[4],
                UserModel().mockData[5]
            ],
            events: []
        ),
            Boat(boatId: "2", name: "Les Rapetous", type: "Muscadet", number: 30034, image: "https://media01.adonnante.com/media/2016/06/monotype-national-muscadet-2016-pierrick-contin-1281-1168x750.jpg", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
            ], 
            events: []
        ),
            Boat(boatId: "3", name: "L'EPAD", type: "Tracteur", number: 32114, image: "https://www.boat-specs.com/img/boat/199/jeanneau-sun-fast-3200-ext-2.jpg", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
                UserModel().mockData[4],
                UserModel().mockData[5]
            ], 
            events: []
        ),
            Boat(boatId: "4", name: "Manche Evidence", type: "Class 40", number: 33323, image: "https://www.manche.fr/wp-content/uploads/2023/03/manche-sport-evidence-nautique-cd50-ddaguier-04.jpg", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
            ], 
            events: []
        ),
            Boat(boatId: "5", name: "Calisto", type: "SunFast 3200", number: 32222, image: "https://www.yachts.co/wp-content/gallery/jeanneau-sun-fast-3200-r2/Jeanneau-Sun-Fast-3200-R2-Exterior-Network-Yachts14.JPG", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
                UserModel().mockData[4],
                UserModel().mockData[5]
            ], 
            events: []
        ),
    ]
    
    
}
