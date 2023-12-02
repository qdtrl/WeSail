//
//  Room.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import Foundation

class ChatsModel: ObservableObject {
    @Published var chats = [Chat]()

    func getSearchdRooms(query: String) -> [Chat] {
        let lastMessageRooms = chats.sorted {
            let date1 = $0.messages.last!.date
            let date2 = $1.messages.last!.date
            return date1 > date2
            
        }
        
        if query == "" {
            return lastMessageRooms
        }
        
        return lastMessageRooms.filter { $0.messages.last!.text.lowercased().contains(query.lowercased())}
    }
    
    func getSectionMessages(for chat: Chat) -> [[Message]] {
        var res = [[Message]]()
        var tmp = [Message]()
        for message in chat.messages {
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
    
    func markAsRead(_ newValue: Bool, chat: Chat) {
        if let index = chats.firstIndex(where: {$0.id == chat.id}) {
            var lastMessage = chats[index].messages.popLast()!
            lastMessage.isRead = newValue
            chats[index].messages.append(lastMessage)
        }
    }
    
    func postMessage(_ text: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id}) {
            let message = Message(userId: "2", userName: "", text: text, date: Date(), isRead: false, userImage: "person.fill")
            chats[index].messages.append(message)
            return message
        } else {
            return nil
        }
    }
            
    
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
