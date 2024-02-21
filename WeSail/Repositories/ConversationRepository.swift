//
//  ChatRepository.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 09/02/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol ConversationRepositoryProtocol {
    func index() async throws -> [Conversation]
    func show(id: String) async throws -> Conversation
    func create(conversation: Conversation) async throws
    func update(conversation: Conversation) async throws
    func delete(conversation: Conversation) async throws
}

final class ConversationRepository:ConversationRepositoryProtocol {
    private let collection = Firestore.firestore().collection("conversations")
    private let storage = Storage.storage()
        
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func index() async throws -> [Conversation] {
        let snapshot = try await collection.getDocuments()
        var conversations: [Conversation] = []
        for document in snapshot.documents {
            let conversation = try document.data(as: Conversation.self)
            conversations.append(conversation)
        }
        return conversations
    }
    
    func show(id: String) async throws -> Conversation {
        let document = document(id: id)
        let snapshot = try await document.getDocument()
        let conversation = try snapshot.data(as: Conversation.self)
        return conversation
    }

   func create(conversation: Conversation) async throws {
        let _ = try collection.addDocument(from: conversation)
    }
    
    func update(conversation: Conversation) async throws {
        let document = document(id: conversation.id)
        try document.setData(from: conversation)
    }
    
    func delete(conversation: Conversation) async throws {
        let document = document(id: conversation.id)
        try await document.delete()
    }
    
}
