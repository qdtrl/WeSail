//
//  User.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct User: Decodable, Identifiable {
    var id = UUID()
    let userId: String
    let email: String
    let firstName: String
    let lastName: String
    let image: String
}

class UserModel: ObservableObject {
    @Published var users = [User]()
    
    @Published var mockData = [
        User(userId: "1", email: "quentindtouroul@gmail.com", firstName: "Quentin", lastName: "Touroul", image: "https://avatars.githubusercontent.com/u/53430120?s=400&v=4"),
        User(userId: "2", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont", image: "https://get.wallhere.com/photo/1920x1200-px-fish-fishes-nature-ocean-sea-sealife-underwater-1649395.jpg"),
        User(userId: "4", email: "alicia.dujardin@wesail.fr", firstName: "Alicia", lastName: "Dujardin", image: "https://s1.1zoom.me/big0/604/393914-blackangel.jpg"),
        User(userId: "5", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Demaison", image: "http://jardinsduciel.j.a.pic.centerblog.net/o/90e16367.jpg"),
        User(userId: "6", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson", image: "https://www.numerama.com/content/uploads/2016/04/poisson-clown-4-jpg.jpg"),
        User(userId: "7", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon", image: "https://get.wallhere.com/photo/1600x1200-px-fish-fishes-nature-ocean-sea-sealife-underwater-1649265.jpg")
    ]
}

