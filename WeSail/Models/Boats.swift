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
            boatId: "1", boatName: "Boat 1", boatImage: "sailboat", crew: [
                User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ],
            events: []
        ),
            Boat(boatId: "2", boatName: "Boat 2", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "3", boatName: "Boat 3", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "4", boatName: "Boat 4", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "5", boatName: "Boat 5", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "6", boatName: "Boat 6", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "7", boatName: "Boat 7", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "8", boatName: "Boat 8", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "9", boatName: "Boat 9", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        ),
            Boat(boatId: "10", boatName: "Boat 10", boatImage: "sailboat", crew: [
                 User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"), 
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"), 
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"), 
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ], 
            events: []
        )
    ]
    
    
}
