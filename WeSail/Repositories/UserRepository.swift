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
    func update(user: User, image: UIImage, completion: @escaping(_ user: User) -> Void) async throws
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
    
    func update(user: User, image: UIImage, completion: @escaping(_ user: User) -> Void) async throws {
        if image == UIImage() {
            do {
                let document = document(id: user.id)
                try document.setData(from: user)
                completion(user)
            } catch {
                throw NSError()
            }
            return
        }
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/users/\(UUID().uuidString).jpg")
        guard let data = image.jpegData(compressionQuality: 0.75) else {
            throw NSError()
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(data, metadata: metadata).observe(.success) { snapshot in
            imageRef.downloadURL { [self] (url, error) in
                Task {
                    if error != nil {
                        throw NSError()
                    } else {
                        if let url = url?.absoluteString {
                            var userUpdate = user
                            userUpdate.image = url
                            do {
                                let document = document(id: userUpdate.id)
                                try document.setData(from: userUpdate)
                                userUpdate.id = user.id
                                completion(userUpdate)
                            } catch {
                                throw NSError()
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
}
