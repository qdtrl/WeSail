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

final class EventManager {
    private let collection = Firestore.firestore().collection("events")
    private let storage = Storage.storage()
    
    @Published var events: [Event] = []
    
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func get() {
        collection.addSnapshotListener{ querySnapshot, error in
                if let error = error {
                    print("Error getting : \(error.localizedDescription)")
                    return
                }
                
                let snapshot = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Event.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.events = snapshot
                }
            }
    }

   func create(event: Event) async throws {
        let _ = try collection.addDocument(from: event)
    }
    
    func update(user: User) async throws {
        let document = document(id: user.id)
        try document.setData(from: user)
    }
    
    func delete(id: String) async throws {
        let document = document(id: id)
        try await document.delete()
    }
    
}
