//
//  User.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct User: Decodable, Identifiable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
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
        User(userId: "4", email: "alicia.dujardin@wesail.fr", firstName: "Alicia", lastName: "Dujardin", image: "https://storage.googleapis.com/assets-monsite-medias/monsitemoncommerce.com-philanima/2019/10/36938ded-eau-de-mer-poisson1.jpg"),
        User(userId: "5", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Demaison", image: "https://www.fishipedia.fr/wp-content/uploads/2015/01/Betta-splendens_8714-min.jpg"),
        User(userId: "6", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson", image: "https://ekladata.com/rOrcQGsG4yDl6aH2AfC3l2bD_-A.jpg"),
        User(userId: "7", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon", image: "https://get.wallhere.com/photo/1600x1200-px-fish-fishes-nature-ocean-sea-sealife-underwater-1649265.jpg")
    ]
}

