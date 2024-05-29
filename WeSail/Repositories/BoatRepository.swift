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
    func show(id: String) async throws -> Boat
    func getCrew(boat: Boat) async throws -> [User]
    func create(boat: Boat, image: UIImage, completion: @escaping(_ boat: Boat) -> Void) async throws
    func joinBoat(boat: Boat, user: User, completion: @escaping(_ boat: Boat) -> Void) async throws
    func uploadImage(boat: Boat, image: UIImage, completion: @escaping(_ boat: Boat) -> Void) async throws
    func addEvent(boat: Boat, name: String, startDate: Date, endDate: Date, completion: @escaping(_ boat: Boat) -> Void) async throws
    func joinBoatEvent(boat: Boat, event: Event, user: User, completion: @escaping(_ boat: Boat) -> Void) async throws
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

    func show(id: String) async throws -> Boat {
        let snapshot = try await document(id: id).getDocument()

        var boat = try snapshot.data(as: Boat.self)
        
        boat.id = snapshot.documentID
       
        return boat
    }

    func getCrew(boat: Boat) async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").whereField("id", in: boat.crew).getDocuments()
        
        var users: [User] = []
        for document in snapshot.documents {
            var user = try document.data(as: User.self)
            user.id = document.documentID
            users.append(user)
        }
        
        return users
    }

    func create(boat: Boat, image: UIImage, completion: @escaping(_ boat: Boat) -> Void) async throws {
       let storageRef = storage.reference()
       let imageRef = storageRef.child("images/boats/cover/\(UUID().uuidString).jpg")
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
                           var boatUpdate = boat
                           boatUpdate.image = url
                           do {
                                let created = try collection.addDocument(from: boatUpdate)
                                boatUpdate.id = created.documentID
                           } catch {
                               throw NSError()
                           }
                           completion(boatUpdate)
                       }
                   }
                   
               }
           }
       }
        
    }

    func uploadImage(boat: Boat, image: UIImage, completion: @escaping(_ boat: Boat) -> Void) async throws {
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
                            var boatUpdate = boat
                            boatUpdate.id = document.documentID
                            boatUpdate.images.append(url)
                            completion(boatUpdate)
                        }
                    }
                }
            }
        }
    }

    func addEvent(boat: Boat, name: String, startDate: Date, endDate: Date, completion: @escaping(_ boat: Boat) -> Void) async throws {
        let event = Event(id: "\(boat.events.count + 1)",name: name, startDate: startDate, endDate: endDate, createdAt: Date(), participants: [])
        let document = collection.document(boat.id)
        do {
            try await document.updateData(["events": FieldValue.arrayUnion([event.dictionaryValue])])
        } catch {
            throw NSError()
        }
        var updateBoat = boat
        updateBoat.id = document.documentID
        updateBoat.events.append(event)
        completion(updateBoat)
    }
    
    func joinBoat(boat: Boat, user: User, completion: @escaping(_ boat: Boat) -> Void) async throws {
        let document = collection.document(boat.id)
        do {
            try await document.updateData(["crew": FieldValue.arrayUnion([user.id])])
        } catch {
            throw NSError()
        }
        var updateBoat = boat
        updateBoat.id = document.documentID
        updateBoat.crew.append(user.id)
        completion(updateBoat)
    }
    
    func joinBoatEvent(boat: Boat, event: Event, user: User, completion: @escaping(_ boat: Boat) -> Void) async throws {
        let document = collection.document(boat.id)
        var eventsUpdated = boat.events
        if let index = eventsUpdated.firstIndex(where: { $0.id == event.id }) {
            eventsUpdated[index].participants.append(user.id)
        }
        do {
            try await document.updateData(["events": eventsUpdated])
        } catch {
            throw NSError()
        }
        var updateBoat = boat
        updateBoat.events = eventsUpdated
        completion(updateBoat)    
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
