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
    func index(userId: String) async throws -> [Conversation]
    func show(conversationId: String) async throws -> Conversation
    func create(conversation: Conversation) async throws -> Conversation
    func update(conversation: Conversation) async throws
    func delete(conversation: Conversation) async throws
}

final class ConversationRepository:ConversationRepositoryProtocol {
    private let collection = Firestore.firestore().collection("conversations")
    
    private let storage = Storage.storage()
    
    private func document(id: String) -> DocumentReference {
        collection.document(id)
    }
    
    func index(userId: String) async throws -> [Conversation] {
        let snapshot = try await collection.whereField("users", arrayContains: userId).getDocuments()
        
        var conversations: [Conversation] = []

        for document in snapshot.documents {
            var conversation = try document.data(as: Conversation.self)
            conversation.id = document.documentID

            conversations.append(conversation)
        }

        return conversations
    }
    
    func show(conversationId: String) async throws -> Conversation {
        let document = try await document(id: conversationId).getDocument()

        var conversation = try document.data(as: Conversation.self)
        conversation.id = document.documentID

        return conversation
    }

   func create(conversation: Conversation) async throws -> Conversation {
        let document = try collection.addDocument(from: conversation)

        var conversationUpdated = conversation
        conversationUpdated.id = document.documentID

        return conversationUpdated
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
