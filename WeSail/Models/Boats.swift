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
            boatId: "1", name: "Les Rapetous", type: "Class 10", image: "https://scontent-cdg4-2.xx.fbcdn.net/v/t39.30808-6/387170307_10225859109128807_1667822856405547801_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=c42490&_nc_ohc=lu-cygU_ymcAX90AMu_&_nc_ht=scontent-cdg4-2.xx&oh=00_AfC6JNd1D9f-2fEmgxfF2wpJOYb7kaoCMtz3nDSj6QDfqw&oe=65729394", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
                UserModel().mockData[4],
                UserModel().mockData[5]
            ],
            events: []
        ),
            Boat(boatId: "2", name: "Les Rapetous", type: "Muscadet", image: "https://scontent-cdg4-3.xx.fbcdn.net/v/t39.30808-6/360150027_10225320431102193_9170067401941400322_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=c42490&_nc_ohc=wF7L5U2fGuAAX92xKPQ&_nc_ht=scontent-cdg4-3.xx&oh=00_AfD7jt2Ug1ujeKb0EWVvlptPx9vDigTbwRNrIlY5upUmMw&oe=6573A5A2", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
            ], 
            events: []
        ),
            Boat(boatId: "3", name: "L'EPAD", type: "Tracteur", image: "https://scontent-cdg4-3.xx.fbcdn.net/v/t39.30808-6/351308179_761308578808050_6266933076603875102_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=c42490&_nc_ohc=joqYjBMtegAAX9Z8S7h&_nc_ht=scontent-cdg4-3.xx&oh=00_AfBgwqx1IEnjmaAGvTM9OA5pCXm4gNx4mL95Fhlkx_-26A&oe=65737665", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[3],
                UserModel().mockData[4],
                UserModel().mockData[5]
            ], 
            events: []
        ),
            Boat(boatId: "4", name: "Manche Evidence", type: "Class 40", image: "https://scontent-cdg4-1.xx.fbcdn.net/v/t39.30808-6/406006481_10226065145799595_2249301651716941697_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=c42490&_nc_ohc=kVeTnlVGfLcAX99Bnq3&_nc_ht=scontent-cdg4-1.xx&oh=00_AfBUF2paGvjq-D_8gatF0mU3V4lOpPAkt0-T9ceHGaa_Lg&oe=6573309D", crew: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
            ], 
            events: []
        ),
            Boat(boatId: "5", name: "Calisto", type: "SunFast 3200", image: "https://scontent-cdg4-1.xx.fbcdn.net/v/t39.30808-6/407721910_722802676544038_1686366022431694066_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=3635dc&_nc_ohc=7p69DbvQqvkAX9TQ7RY&_nc_ht=scontent-cdg4-1.xx&oh=00_AfCyRZTSmlJuL0YtukVRXDdWBbsXZqu9fdM86xquJLNCIw&oe=65724E4A", crew: [
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
