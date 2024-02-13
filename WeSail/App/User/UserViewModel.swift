//
//  UserViewModel.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 29/12/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    var repository:UserRepositoryProtocol
    @Published var users: [User] = []
    @Published var events: [Event] = []
    @Published var boats: [Boat] = []
    @Published var images: [String] = []
    @Published var user: User? = nil

    @Published var isLoading:Bool = false

    init() {
        self.repository = UserRepository()
    }
    
    func events(user: User) {
        Task { @MainActor in
            self.isLoading = true

            self.events = try await self.repository.events(userId: user.id)
            
            self.isLoading = false
        }
    }

    func boats(user: User) {
        Task { @MainActor in
            self.isLoading = true

            self.boats = try await self.repository.boats(userId: user.id)
            
            self.isLoading = false
        }
    }

    func images(user: User) {
        Task { @MainActor in
            self.isLoading = true

            self.images = try await self.repository.images(userId: user.id)
            
            self.isLoading = false
        }
    }

    func show(userId: String) {
        Task { @MainActor in
            self.isLoading = true

            self.user = try await self.repository.show(id: userId)
            
            self.isLoading = false
        }
    }
    
    @Published var mockData = [
        User(id: "1", email: "quentindtouroul@gmail.com", firstName: "Quentin", lastName: "Touroul", image: "https://avatars.githubusercontent.com/u/53430120?s=400&v=4"),
        User(id: "2", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont", image: "https://get.wallhere.com/photo/1920x1200-px-fish-fishes-nature-ocean-sea-sealife-underwater-1649395.jpg"),
        User(id: "4", email: "alicia.dujardin@wesail.fr", firstName: "Alicia", lastName: "Dujardin", image: "https://storage.googleapis.com/assets-monsite-medias/monsitemoncommerce.com-philanima/2019/10/36938ded-eau-de-mer-poisson1.jpg"),
        User(id: "5", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Demaison", image: "https://www.fishipedia.fr/wp-content/uploads/2015/01/Betta-splendens_8714-min.jpg"),
        User(id: "6", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson", image: "https://ekladata.com/rOrcQGsG4yDl6aH2AfC3l2bD_-A.jpg"),
        User(id: "7", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon", image: "https://get.wallhere.com/photo/1600x1200-px-fish-fishes-nature-ocean-sea-sealife-underwater-1649265.jpg")
    ]
}
