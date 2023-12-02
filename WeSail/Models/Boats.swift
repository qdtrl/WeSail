//
//  Boats.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation

class BoatsModel: ObservableObject {
    @Published var boats = [Boat]()            
    
    @Published var mockData = [
        Chat(
            chatId: "1",
            chatName: "Planche à voile",
            chatImage: "figure.sailing",
            users: [
                User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"),
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon")
            ],
            messages: [
                Message(userId: "1", userName: "Robert Dupont", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "See you soon", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "See you", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "See you soon", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "See you", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "2", userName: "Alicia Japon", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
            ]
        ),
        Chat(
            chatId: "2",
            chatName: "Voilier",
            chatImage: "sailboat",
            users: [
                User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"),
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"),
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ],
            messages: [
                Message(userId: "3", userName: "Angèle Chanteuse", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "4", userName: "Paul Hudson", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "5", userName: "Jason Dubon", text: "How are you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "3", userName: "Angèle Chanteuse", text: "Fine and you ?", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "4", userName: "Paul Hudson", text: "I'm fine too", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "5", userName: "Jason Dubon", text: "Great !", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "1", userName: "Robert Dupont", text: "See you soon", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "4", userName: "Paul Hudson", text: "See you", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "3", userName: "Angèle Chanteuse", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"),
                Message(userId: "4", userName: "Paul Hudson", text: "Hi", date: Date(), isRead: false, userImage: "person.fill"),
            ]
        ),
        Chat(
            chatId: "3",
            chatName: "Kitesurf",
            chatImage: "figure.surfing",
            users: [
                User(userId: "1", email: "robert.dupont@wesail.fr", firstName: "Robert", lastName: "Dupont"),
                User(userId: "2", email: "alicia.japon@wesail.fr", firstName: "Alicia", lastName: "Japon"),
                User(userId: "3", email: "angele.chanteuse@wesail.fr", firstName: "Angèle", lastName: "Chanteuse"),
                User(userId: "4", email: "paul.hudson@wesail.fr", firstName: "Paul", lastName: "Hudson"),
                User(userId: "5", email: "jason.dubon@wesail.fr", firstName: "Jason", lastName: "Dubon")
            ],
            messages: [
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
        ),
    ]
    
    
}
