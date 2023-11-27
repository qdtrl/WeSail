//
//  Chat.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messsages = [Message]()

    @Published var mockData = [
        Message(userUid: "userUid", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "otherUserUid", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "userUid", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "otherUserUid", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "userUid", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "otherUserUid", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "userUid", text: "See you soon", date: Date(), isRead: false, userImage: "person.fill"),
        Message(userUid: "otherUserUid", text: "See you", date: Date(), isRead: false, userImage: "person.fill"),
    ]
    
    
}
