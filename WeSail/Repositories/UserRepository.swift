//
//  UserManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 30/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

final class UserManager {
    private let collection = Firestore.firestore().collection("users")
    private let storage = Storage.storage()
    
    @Published var users: [User] = []
    
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
                    try? document.data(as: User.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.users = snapshot
                }
            }
    }

   func create(user: User) async throws {
        let _ = try collection.addDocument(from: user)
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
