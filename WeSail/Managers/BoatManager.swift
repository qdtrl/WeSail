//
//  UserManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 29/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class BoatManager {
    static let shared = BoatManager()
    
    init() {}
    
    private let boatCollection = Firestore.firestore().collection("boats")
    
    private func boatDocument(id: String) -> DocumentReference {
        boatCollection.document(id)
    }
    
    func getBoats() async throws -> [Boat] {
        let snapshot = try await boatCollection.getDocuments()
        var boats: [Boat] = []
        for document in snapshot.documents {
            let boat = try document.data(as: Boat.self)
            boats.append(boat)
        }
        return boats
    }

    func getBoat(id: String) async throws {
//        let document = boatDocument(id: id)
//        let snapshot = try await document.getDocument()
//        guard let boat = try snapshot.data(as: Boat.self) else {
//            return
//        }
    }
    
   func createBoat(boat: Boat) async throws {
        let _ = try await boatCollection.addDocument(from: boat)
    }
    
    func updateBoat(boat: Boat) async throws {
        let document = boatDocument(id: boat.id)
        try await document.setData(from: boat)
    }
    
    func deleteBoat(id: String) async throws {
        let document = boatDocument(id: id)
        try await document.delete()
    }
    
    func addEventToBoat(boatId: String, eventId: String) async throws {
        let document = boatDocument(id: boatId)
        try await document.updateData(["events": FieldValue.arrayUnion([eventId])])
    }
    
    func removeEventFromBoat(boatId: String, eventId: String) async throws {
        let document = boatDocument(id: boatId)
        try await document.updateData(["events": FieldValue.arrayRemove([eventId])])
    }
    
    func addCrewToBoat(boatId: String, crewId: String) async throws {
        let document = boatDocument(id: boatId)
        try await document.updateData(["crew": FieldValue.arrayUnion([crewId])])
    }
    
    func removeCrewFromBoat(boatId: String, crewId: String) async throws {
        let document = boatDocument(id: boatId)
        try await document.updateData(["crew": FieldValue.arrayRemove([crewId])])
    }
    
    func addBoatToUser(boatId: String, userId: String) async throws {
        let document = UserManager.shared.userDocument(id: userId)
        try await document.updateData(["boats": FieldValue.arrayUnion([boatId])])
    }
    
    func removeBoatFromUser(boatId: String, userId: String) async throws {
        let document = UserManager.shared.userDocument(id: userId)
        try await document.updateData(["boats": FieldValue.arrayRemove([boatId])])
    }
    
    func addBoatToEvent(boatId: String, eventId: String) async throws {
        let document = EventManager.shared.eventDocument(id: eventId)
        try await document.updateData(["boats": FieldValue.arrayUnion([boatId])])
    }
    
    func removeBoatFromEvent(boatId: String, eventId: String) async throws {
        let document = EventManager.shared.eventDocument(id: eventId)
        try await document.updateData(["boats": FieldValue.arrayRemove([boatId])])
    }
}
