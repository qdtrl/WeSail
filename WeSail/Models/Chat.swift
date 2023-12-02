//
//  Chat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

struct Chat: Decodable, Identifiable {
    var id = UUID()
    let chatId: String
    let chatName: String
    let chatImage: String
    let users: [User]
    var messages: [Message]
}

class ChatModel: ObservableObject {
    @Published var messages = [Message]()

    @Published var mockData = [
        Message(userId: "1", userName: "Robert Dupont", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "2", userName: "Alicia Japon", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "3", userName: "Angèle Chanteuse", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "4", userName: "Paul Hudson", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "5", userName: "Jason Dubon", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "1", userName: "Robert Dupont", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"), 
        Message(userId: "2", userName: "Alicia Japon", text: "See you soon", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "3", userName: "Angèle Chanteuse", text: "See you", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "1", userName: "Robert Dupont", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "2", userName: "Alicia Japon", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "3", userName: "Angèle Chanteuse", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "4", userName: "Paul Hudson", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "5", userName: "Jason Dubon", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userId: "1", userName: "Robert Dupont", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"),
    ]
}
