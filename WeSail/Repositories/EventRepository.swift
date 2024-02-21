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
    func index() async throws -> [Event]
}

final class EventRepository:EventRepositoryProtocol {
    private let collection = Firestore.firestore().collection("events")
    private let storage = Storage.storage()
        
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func index() async throws -> [Event] {
        let snapshot = try await collection.getDocuments()
        var events: [Event] = []
        for document in snapshot.documents {
            let event = try document.data(as: Event.self)
            events.append(event)
        }
        return events
    }
}
