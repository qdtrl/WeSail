//
//  EventManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 30/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol EventRepositoryProtocol {
    func indexBoatEvents(boatId: String) async throws -> [Event]
    func indexUserEvents(userId: String) async throws -> [Event]
    func create(event: Event) async throws -> Event
    func update(event: Event) async throws -> Event
    func joinEvent(event: Event, userId: String) async throws -> Event
}

final class EventRepository:EventRepositoryProtocol {
    private let collection = Firestore.firestore().collection("events")
    private let storage = Storage.storage()
        
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func indexBoatEvents(boatId: String) async throws -> [Event] {
        let snapshot = try await collection.whereField("boatId", isEqualTo: boatId).getDocuments()
        var events: [Event] = []
        for document in snapshot.documents {
            let event = try document.data(as: Event.self)
            events.append(event)
        }
        return events
    }

    func indexUserEvents(userId: String) async throws -> [Event] {
        let snapshot = try await collection.whereField("participants", arrayContains: userId).getDocuments()
        var events: [Event] = []
        for document in snapshot.documents {
            let event = try document.data(as: Event.self)
            events.append(event)
        }
        return events
    }

    func create(event: Event) async throws -> Event {
        var event = event
        let document = try await collection.addDocument(from: event)
        event.id = document.documentID
        return event
    }

    func update(event: Event) async throws -> Event {
        let document = document(id: event.id)
        try await document.setData(from: event)
        return event
    }

    func joinEvent(event: Event, userId: String) async throws -> Event {
        var event = event
        event.participants.append(userId)
        return try await update(event: event)
    }
}
