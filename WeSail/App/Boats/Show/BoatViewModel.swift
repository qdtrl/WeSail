//
//  BoatViewModel.swift
//  WeSail
//
//  Created by Quentin Touroul on 07/08/2024.
//

import Foundation

import UIKit

class BoatViewModel: ObservableObject {
    var repository:BoatRepositoryProtocol
    var boat: Boat? = nil
    var crew: [User] = []
    var events: [Event] = []
    var images: [String] = []
    var isLoading: Bool = false
    
    init() {
        self.repository = BoatRepository()
    }
    
    func show(id: String) {
        Task { @MainActor in
            self.isLoading = true

            self.boat = try await self.repository.show(id: id)
            self.crew = try await self.repository.getCrew(crew: self.boat!.crew)

            self.isLoading = false
        }
    }
    
    func uploadImageToBoat(_ boat: Boat, _ image: UIImage, completion: @escaping (Boat) -> Void) {
        Task { @MainActor in
            self.isLoading = true

            try await self.repository.uploadImage(boat: boat, image: image) {
                updateBoat in
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion(updateBoat)
                }
            }
        }
    }

    func joinBoat(user: User) {
        Task { @MainActor in
            guard let boat = boat else { return }
            self.isLoading = true

            try await self.repository.joinBoat(boat: boat, user: user) {
                updateBoat in
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.boat = updateBoat
                }
            }
        }
    }

    func update(boat: Boat, image: UIImage) {
        Task { @MainActor in
            self.isLoading = true

            try await self.repository.update(boat: boat, image: image) {
                boatUpdated in
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.boat = boatUpdated
                }
            }
        }
    }
}
