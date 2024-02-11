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

protocol UserRepositoryProtocol {
    func index() async throws -> [User]
    func update(user: User) async throws
    func delete(id: String) async throws
}

final class UserRepository: UserRepositoryProtocol{
    private let collection = Firestore.firestore().collection("users")
    private let storage = Storage.storage()
        
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func index() async throws -> [User] {
        let snapshot = try await collection.getDocuments()
        var users: [User] = []
        for document in snapshot.documents {
            let user = try document.data(as: User.self)
            users.append(user)
        }
        return users
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
