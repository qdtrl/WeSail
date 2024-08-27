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
    var eventRepository:EventRepositoryProtocol
    
    @Published var id: String
    @Published var boat: Boat? = nil
    @Published var crew: [User] = []
    @Published var events: [Event] = []
    @Published var isLoading: Bool = true
    
    init(id: String) {
        self.id = id
        self.repository = BoatRepository()
        self.eventRepository = EventRepository()
        self.show()
    }
    
    func show() {
        Task { @MainActor in
            self.isLoading = true
        
            self.boat = try await self.repository.show(id: self.id)
            self.crew = try await self.repository.getCrew(crew: self.boat!.crew)
            self.events = try await self.eventRepository.indexBoatEvents(boatId: self.id)

            self.isLoading = false
        }
    }
    
    func uploadImageToBoat(_ image: UIImage) {
        Task { @MainActor in
            self.isLoading = true

            try await self.repository.uploadImage(boat: self.boat!, image: image) {
                updateBoat in
                DispatchQueue.main.async {
                    self.boat = updateBoat
                    self.isLoading = false
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
                    self.boat = updateBoat
                    self.isLoading = false
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
                    self.boat = boatUpdated
                    self.isLoading = false
                }
            }
        }
    }
}
