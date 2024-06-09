//
//  EventViewModel.swift
//  WeSail
//
//  Created by Quentin Touroul on 08/06/2024.
//

import Foundation

class EventsViewModel: ObservableObject {
    var repository:EventRepositoryProtocol

    @Published var events: [Event] = []
    @Published var isLoading:Bool = false

    init() {
        self.repository = EventRepository()
    }

    func indexBoatEvents(boatId: String) {
        Task { @MainActor in
            self.isLoading = true

            self.events = try await self.repository.indexBoatEvents(boatId: boatId)

            self.isLoading = false
        }
    }

    func indexUserEvents(userId: String) {
        Task { @MainActor in
            self.isLoading = true

            self.events = try await self.repository.indexUserEvents(userId: userId)

            self.isLoading = false
        }
    }

    func create(event: Event, completion: @escaping (Event) -> Void) {
        Task { @MainActor in
            do {
                let createdEvent = try await self.repository.create(event: event)
                completion(createdEvent)
            } catch {
                print("Error creating event")
            }
        }
    }

    func update(event: Event, completion: @escaping (Event) -> Void) {
        Task { @MainActor in
            do {
                let updatedEvent = try await self.repository.update(event: event)
                completion(updatedEvent)
            } catch {
                print("Error updating event")
            }
        }
    }

    func joinEvent(event: Event, userId: String, completion: @escaping (Event) -> Void) {
        Task { @MainActor in
            do {
                let joinedEvent = try await self.repository.joinEvent(event: event, userId: userId)
                completion(joinedEvent)
            } catch {
                print("Error joining event")
            }
        }
    }
}