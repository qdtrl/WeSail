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
    func create(boat: Boat, image: UIImage) async throws
    func uploadImage(boat: Boat, image: UIImage) async throws
    func addEvent(boat: Boat, name: String, startDate: Date, endDate: Date) async throws
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
            var boat = try document.data(as: Boat.self)
            boat.id = document.documentID
            boats.append(boat)
        }
        return boats
    }

    func create(boat: Boat, image: UIImage) async throws {
       let storageRef = storage.reference()
       let imageRef = storageRef.child("images/boats/cover/\(UUID().uuidString).jpg")
       guard let data = image.jpegData(compressionQuality: 0.75) else {
           throw NSError()
       }

       let metadata = StorageMetadata()
       metadata.contentType = "image/jpeg"
       
       let document = collection.document(boat.id)
       imageRef.putData(data, metadata: metadata).observe(.success) { snapshot in
           imageRef.downloadURL { [self] (url, error) in
               Task {
                   if error != nil {
                       throw NSError()
                   } else {
                       if let url = url?.absoluteString {
                           var boatUpdate = boat
                           boatUpdate.image = url
                           do {
                               try collection.addDocument(from: boatUpdate)
                           } catch {
                               throw NSError()
                           }
                       }
                   }
               }
           }
       }
       
    }

    func uploadImage(boat: Boat, image: UIImage) async throws {
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/boats/\(boat.id)/\(UUID().uuidString).jpg")
        guard let data = image.jpegData(compressionQuality: 0.75) else {
            throw NSError()
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let document = collection.document(boat.id)
        imageRef.putData(data, metadata: metadata).observe(.success) { snapshot in
            imageRef.downloadURL { (url, error) in
                Task {
                    if error != nil {
                        throw NSError()
                    } else {
                        if let url = url?.absoluteString {
                            do {
                                try await document.updateData(["images": FieldValue.arrayUnion([url])])
                            } catch {
                                throw NSError()
                            }
                        }
                    }
                }
            }
        }
    }

    func addEvent(boat: Boat, name: String, startDate: Date, endDate: Date) async throws {
        let event = Event(id: "\(boat.events.count + 1)",name: name, startDate: startDate, endDate: endDate, createdAt: Date(), participants: [])
        let document = collection.document(boat.id)
        try await document.updateData(["events": FieldValue.arrayUnion([event.dictionaryValue])])
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
