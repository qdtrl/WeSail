//
//  UserManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 29/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol BoatRepositoryProtocol {
    func index() async throws -> [Boat]
    func create(boat: Boat) async throws
    func update(boat: Boat) async throws
    func delete(boat: Boat) async throws
}

final class BoatRepository:BoatRepositoryProtocol {
    private let collection = Firestore.firestore().collection("boats")
    private let storage = Storage.storage()
        
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func index() async throws -> [Boat] {
        let snapshot = try await collection.getDocuments()
        var boats: [Boat] = []
        for document in snapshot.documents {
            let boat = try document.data(as: Boat.self)
            boats.append(boat)
        }
        return boats
    }

   func create(boat: Boat) async throws {
        let res = try collection.addDocument(from: boat)
       print(res)
    }
    
    func update(boat: Boat) async throws {
        let document = document(id: boat.id)
        try document.setData(from: boat)
    }
    
    func delete(boat: Boat) async throws {
        let document = document(id: boat.id)
        try await document.delete()
    }
    
}
