//
//  Conversations.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation

class ConversationsViewModel: ObservableObject {
    var repository:ConversationRepositoryProtocol

    @Published var conversations: [Conversation] = []
    @Published var conversation: Conversation? = nil
    @Published var isLoading:Bool = false
    @Published var isLoadingMessage:Bool = false

    init() {
        self.repository = ConversationRepository()
    }
    
    func index() {
        Task { @MainActor in
            self.isLoading = true

            self.conversations = try await self.repository.index()
            
            self.isLoading = false
        }
    }
    
    func create(_ conversation: Conversation) {
        Task { @MainActor in
            self.isLoading = true
           
            try await self.repository.create(conversation: conversation)
            
            self.conversations.append(conversation)

            self.isLoading = false
        }
    }
    
    func show(conversationId: String) {
        Task { @MainActor in
            self.isLoading = true

            self.conversation = try await self.repository.show(id: conversationId)
            
            self.isLoading = false
        }
    }
    
    func post(message: Message) {
        Task { @MainActor in
            self.isLoadingMessage = true
            
            guard var conversation = self.conversation else {return}
            
            guard let messages = conversation.messages else {return}
            
            conversation.messages = messages + [message]
            
            try await self.repository.update(conversation: conversation)
            
            self.conversation = conversation
            
            self.isLoadingMessage = false
        }
    }
    
    func markLastMessageAsRead(user: User,conversation: Conversation) {
        Task { @MainActor in
            guard var lastMessage = conversation.messages?.last else { return }
            
            if lastMessage.user.id == user.id { return }
            
            lastMessage.isRead = true
            
            try await self.repository.update(conversation: conversation)
        }
    }

//    func getSearchedRooms(query: String) -> [Conversation] {
//        let lastMessageRooms = conversations.sorted {
//            let date1 = $0.messages?.last!.date
//            let date2 = $1.messages?.last!.date
//            return date1 > date2
//        }
//        
//        if query == "" {
//            return lastMessageRooms
//        }
//        
//        return lastMessageRooms.filter { $0.messages.last!.text.lowercased().contains(query.lowercased())}
//    }
    
    func getSectionMessages(for conversation: Conversation) -> [[Message]] {
        var res = [[Message]]()
        var tmp = [Message]()
        guard let messages = conversation.messages else { return res }
        for message in messages {
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
                UserViewModel().mockData[0],
                UserViewModel().mockData[2],
                UserViewModel().mockData[3],
            ], 
            messages: [
                Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false),
                Message(id: "2", user: UserViewModel().mockData[3], text: "Hi", date: Date(), isRead: false),
                Message(id: "3", user: UserViewModel().mockData[2], text: "How are you ?", date: Date(), isRead: false), 
                Message(id: "4", user: UserViewModel().mockData[3], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(id: "5", user: UserViewModel().mockData[2], text: "I'm fine too", date: Date(), isRead: false), 
                Message(id: "6", user: UserViewModel().mockData[3], text: "Great !", date: Date(), isRead: false), 
                Message(id: "7", user: UserViewModel().mockData[2], text: "See you soon", date: Date(), isRead: false), 
                Message(id: "8", user: UserViewModel().mockData[3], text: "See you", date: Date(), isRead: false),
                Message(id: "9", user: UserViewModel().mockData[2], text: "Hello", date: Date(), isRead: false),
                Message(id: "10", user: UserViewModel().mockData[3], text: "Hi", date: Date(), isRead: false),
                Message(id: "11", user: UserViewModel().mockData[2], text: "How are you ?", date: Date(), isRead: false),
                Message(id: "12", user: UserViewModel().mockData[3], text: "Fine and you ?", date: Date(), isRead: false),
                Message(id: "13", user: UserViewModel().mockData[2], text: "I'm fine too", date: Date(), isRead: false),
                Message(id: "14", user: UserViewModel().mockData[3], text: "Great !", date: Date(), isRead: false),
                Message(id: "15", user: UserViewModel().mockData[2], text: "See you soon", date: Date(), isRead: false),
                Message(id: "16", user: UserViewModel().mockData[3], text: "See you", date: Date(), isRead: false),
                Message(id: "17", user: UserViewModel().mockData[2], text: "Hello", date: Date(), isRead: false),
                Message(id: "18", user: UserViewModel().mockData[3], text: "Hi", date: Date(), isRead: false),
            ]
        ),
        Conversation(
            id: "2",
            name: "Voilier",
            image: "https://static.actu.fr/uploads/2016/08/DSC_4578.JPG",
            users: [
                UserViewModel().mockData[0],
                UserViewModel().mockData[4],
                UserViewModel().mockData[5],
            ],
            messages: [
                Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false), 
                Message(id: "2", user: UserViewModel().mockData[4], text: "Hi", date: Date(), isRead: false), 
                Message(id: "3", user: UserViewModel().mockData[5], text: "How are you ?", date: Date(), isRead: false), 
                Message(id: "4", user: UserViewModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(id: "5", user: UserViewModel().mockData[4], text: "I'm fine too", date: Date(), isRead: false), 
                Message(id: "6", user: UserViewModel().mockData[5], text: "Great !", date: Date(), isRead: false), 
                Message(id: "7", user: UserViewModel().mockData[5], text: "See you soon", date: Date(), isRead: false),
                Message(id: "8", user: UserViewModel().mockData[4], text: "See you", date: Date(), isRead: false),
                Message(id: "9", user: UserViewModel().mockData[4], text: "Hello", date: Date(), isRead: false),
                Message(id: "10", user: UserViewModel().mockData[4], text: "Hi", date: Date(), isRead: false),
            ]
        ),

        Conversation(
            id: "3",
            name: "Kitesurf",
            image: "https://www.grupoatman.es/upimagenes/Kitesurf-1.jpg",
            users: [
                UserViewModel().mockData[0],
                UserViewModel().mockData[1],
                UserViewModel().mockData[2],
                UserViewModel().mockData[4],
                
            ],
            messages: [
                Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false), 
                Message(id: "2", user: UserViewModel().mockData[1], text: "Hi", date: Date(), isRead: false), 
                Message(id: "3", user: UserViewModel().mockData[2], text: "How are you ?", date: Date(), isRead: false), 
                Message(id: "4", user: UserViewModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(id: "5", user: UserViewModel().mockData[0], text: "I'm fine too", date: Date(), isRead: false), 
                Message(id: "6", user: UserViewModel().mockData[0], text: "Great !", date: Date(), isRead: false), 
                Message(id: "7", user: UserViewModel().mockData[1], text: "See you soon", date: Date(), isRead: false),
                Message(id: "8", user: UserViewModel().mockData[2], text: "See you", date: Date(), isRead: false),
                Message(id: "9", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false),
                Message(id: "10", user: UserViewModel().mockData[1], text: "Hi", date: Date(), isRead: false),
                Message(id: "11", user: UserViewModel().mockData[2], text: "How are you ?", date: Date(), isRead: false),
                Message(id: "12", user: UserViewModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false),
                Message(id: "13", user: UserViewModel().mockData[0], text: "I'm fine too", date: Date(), isRead: false),
                Message(id: "14", user: UserViewModel().mockData[0], text: "Great !", date: Date(), isRead: false),
            ]
        ),
    ]
    
    
}
