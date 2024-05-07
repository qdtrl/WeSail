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
    func show(id: String) async throws -> User
    func update(user: User) async throws
    func delete(user: User) async throws
    func events(userId: String) async throws -> [Event]
    func boats(userId: String) async throws -> [Boat]
    func images(userId: String) async throws -> [String]
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
            var user = try document.data(as: User.self)
            user.id = document.documentID
            users.append(user)
        }
        return users
    }

    func show(id: String) async throws -> User {
        let document = document(id: id)
        let snapshot = try await document.getDocument()
        let user = try snapshot.data(as: User.self)
        return user
    }
    
    func update(user: User) async throws {
        let document = document(id: user.id)
        try document.setData(from: user)
    }
    
    func delete(user: User) async throws {
        let document = document(id: user.id)
        try await document.delete()
    }
    
    func events(userId: String) async throws -> [Event] {
        let snapshot = try await collection.document(userId).collection("events").getDocuments()
        var events: [Event] = []
        for document in snapshot.documents {
            let event = try document.data(as: Event.self)
            events.append(event)
        }
        return events
    }

    func boats(userId: String) async throws -> [Boat] {
        let snapshot = try await collection.document(userId).collection("boats").getDocuments()
        var boats: [Boat] = []
        for document in snapshot.documents {
            let boat = try document.data(as: Boat.self)
            boats.append(boat)
        }
        return boats
    }

    func images(userId: String) async throws -> [String] {
        let reference = storage.reference().child("users/\(userId)")
        let list = try await reference.listAll()
        var images: [String] = []
        for item in list.items {
            images.append(item.name)
        }
        return images
    } 
}
