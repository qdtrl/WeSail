//
//  Chats.swift
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
            let message = Message(user: UserModel().mockData[0], text: text, date: Date(), isRead: false)
            chats[index].messages.append(message)
            return message
        } else {
            return nil
        }
    }
            
    
    @Published var mockData = [
        Chat(
            chatId: "1", 
            name: "Planche à voile",
            image: "https://cntranchais.com/wp-content/uploads/2018/11/planche-%C3%A0-voile-4.jpg",
            users: [
                UserModel().mockData[0],
                UserModel().mockData[2],
                UserModel().mockData[3],
            ], 
            messages: [
                Message(user: UserModel().mockData[0], text: "Hello", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "Hi", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "How are you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[3], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[2], text: "I'm fine too", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[3], text: "Great !", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[2], text: "See you soon", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[3], text: "See you", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "Hello", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "Hi", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "How are you ?", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "Fine and you ?", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "I'm fine too", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "Great !", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "See you soon", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "See you", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "Hello", date: Date(), isRead: false),
                Message(user: UserModel().mockData[3], text: "Hi", date: Date(), isRead: false),
            ]
        ),
        Chat(
            chatId: "2", 
            name: "Voilier",
            image: "https://static.actu.fr/uploads/2016/08/DSC_4578.JPG",
            users: [
                UserModel().mockData[0],
                UserModel().mockData[4],
                UserModel().mockData[5],
            ],
            messages: [
                Message(user: UserModel().mockData[0], text: "Hello", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[4], text: "Hi", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[5], text: "How are you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[4], text: "I'm fine too", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[5], text: "Great !", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[5], text: "See you soon", date: Date(), isRead: false),
                Message(user: UserModel().mockData[4], text: "See you", date: Date(), isRead: false),
                Message(user: UserModel().mockData[4], text: "Hello", date: Date(), isRead: false),
                Message(user: UserModel().mockData[4], text: "Hi", date: Date(), isRead: false),
            ]
        ),

        Chat(
            chatId: "3", 
            name: "Kitesurf",
            image: "https://www.grupoatman.es/upimagenes/Kitesurf-1.jpg",
            users: [
                UserModel().mockData[0],
                UserModel().mockData[1],
                UserModel().mockData[2],
                UserModel().mockData[4],
                
            ],
            messages: [
                Message(user: UserModel().mockData[0], text: "Hello", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[1], text: "Hi", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[2], text: "How are you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[0], text: "I'm fine too", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[0], text: "Great !", date: Date(), isRead: false), 
                Message(user: UserModel().mockData[1], text: "See you soon", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "See you", date: Date(), isRead: false),
                Message(user: UserModel().mockData[0], text: "Hello", date: Date(), isRead: false),
                Message(user: UserModel().mockData[1], text: "Hi", date: Date(), isRead: false),
                Message(user: UserModel().mockData[2], text: "How are you ?", date: Date(), isRead: false),
                Message(user: UserModel().mockData[4], text: "Fine and you ?", date: Date(), isRead: false),
                Message(user: UserModel().mockData[0], text: "I'm fine too", date: Date(), isRead: false),
                Message(user: UserModel().mockData[0], text: "Great !", date: Date(), isRead: false),
            ]
        ),
    ]
    
    
}
