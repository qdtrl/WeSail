//
//  Conversations.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation
import FirebaseDatabase

class ConversationsViewModel: ObservableObject {
    var repository:ConversationRepositoryProtocol

    @Published var conversations: [Conversation] = []
    @Published var conversationsSearch: [Conversation] = []
    @Published var conversation: Conversation?

    @Published var messages: [Message] = []

    @Published var isLoading:Bool = false
    @Published var isLoadingMessage:Bool = false
    
    private lazy var refDatabasePath: DatabaseReference = {
        let ref = Database.database().reference().child("conversations")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init() {
        self.repository = ConversationRepository()
    }
    
    func index(userId: String) {
        Task { @MainActor in
            self.isLoading = true

            self.conversations = try await self.repository.index(userId: userId)
            self.orderConversations()
            
            self.isLoading = false
        }
    }

    func search(query: String) {
        Task { @MainActor in
            self.isLoading = true

            if (query != "") {
                self.conversationsSearch = self.conversations.filter { $0.name.lowercased().contains(query.lowercased()) }
            } else {
                self.orderConversations()
            }

            self.isLoading = false
        }
    }
    
    func create(_ conversation: Conversation) {
        Task { @MainActor in
            self.isLoading = true
           
            let createdConversation = try await self.repository.create(conversation: conversation)
            
            self.conversations.append(createdConversation)
            self.orderConversations()

            try await self.postMessage(conversationId: createdConversation.id, message: createdConversation.lastMessage)

            self.isLoading = false
        }
    }
    
    func show(conversationId: String) {
        Task { @MainActor in
            self.isLoading = true
            
            self.conversation = try await self.repository.show(conversationId: conversationId)

            try await self.getMessages(conversationId: conversationId)
            
            self.isLoading = false
        }
    }
    
    func post(message: Message) {
        Task { @MainActor in
            guard var updateConversation = conversation else {
                return
            }
            self.isLoadingMessage = true

            updateConversation.lastMessage = message
            
            self.conversation = updateConversation
            
            try await self.repository.update(conversation: updateConversation)
            
            try await self.postMessage(conversationId: updateConversation.id, message: message)

            self.messages.append(message)
            
            self.orderConversations()

            self.isLoadingMessage = false
        }
    }

    func postMessage(conversationId: String, message: Message) async throws {
        let messageData = try JSONEncoder().encode(message)
        let messageDict = try JSONSerialization.jsonObject(with: messageData, options: []) as? [String: Any]
        try await refDatabasePath.child(conversationId).child("messages").child("\(self.messages.count)").setValue(messageDict)
        
    }

    func getMessages(conversationId: String) async throws {
        let snapshot = try await self.refDatabasePath.child(conversationId).child("messages").getData()
        DispatchQueue.main.async {
            self.messages = []
        }
        
        if let messagesDict = snapshot.value as? [[String: Any]] {
            for messageDict in messagesDict {
                do {
                    let messageData = try JSONSerialization.data(withJSONObject: messageDict)
                    let message = try self.decoder.decode(Message.self, from: messageData)
                    DispatchQueue.main.async {
                        self.messages.append(message)
                    }
                } catch {
                    print("an error occurred", error)
                }
            }
        }
    }

    func stopListening() {
        refDatabasePath.removeAllObservers()
    }

    func orderConversations() {
        self.conversations.sort { $0.lastMessage.date > $1.lastMessage.date }
        self.conversationsSearch = self.conversations
    }
    
    func markLastMessageAsRead(conversation: Conversation) {
        Task { @MainActor in
            var updateConversation = conversation
            var lastMessage = updateConversation.lastMessage
            lastMessage.isRead = true
            
            updateConversation.lastMessage = lastMessage
            try await self.repository.update(conversation: conversation)
        }
    }
    
    func getSectionMessages() -> [[Message]] {
        var res = [[Message]]()
        var tmp = [Message]()

        for message in self.messages {
            if let firstMessage = tmp.first {
                let daysBetween = firstMessage.date.daysBetween(date: message.date)
                if daysBetween >= 1 {
                    res.append(tmp)
                    tmp.removeAll()
                    tmp.append(message)
                } else {
                    tmp.append(message)
                }
            }  else {
                tmp.append(message)
            }
        }

        res.append(tmp)
        
        return res
    }
    
    @Published var mockData = [
        Conversation(
            id: "1",
            name: "Planche à voile",
            image: "https://cntranchais.com/wp-content/uploads/2018/11/planche-%C3%A0-voile-4.jpg",
            users: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[3].id,
            ],
            lastMessage: Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false)
                
        ),
        Conversation(
            id: "2",
            name: "Voilier",
            image: "https://static.actu.fr/uploads/2016/08/DSC_4578.JPG",
            users: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[4].id,
                UserViewModel().mockData[5].id,
            ],
            lastMessage: Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false)
        ),

        Conversation(
            id: "3",
            name: "Kitesurf",
            image: "https://www.grupoatman.es/upimagenes/Kitesurf-1.jpg",
            users: [
                UserViewModel().mockData[0].id,
                UserViewModel().mockData[1].id,
                UserViewModel().mockData[2].id,
                UserViewModel().mockData[4].id,
                
            ],
            lastMessage: Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false)
        ),
    ]
    
    
}
