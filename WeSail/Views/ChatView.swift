//
//  ChatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false)  {
                VStack(spacing: 15) {
                    ForEach(chatViewModel.mockData) { message in
                        MessageView(message: message)
                    }
                }
            }
            HStack (alignment: .top) {
                TextField("Message", text: $text, axis: .vertical)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                             
                Button(action: {
                    if !text.isEmpty {
                        chatViewModel.mockData.append(Message(userUid: "userUid", text: text, date: Date(), isRead: false, userImage: "person.fill"))
                        text = ""
                    }
                }, label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(text.isEmpty ? Color.gray : Color.blue)
                        .clipShape(Capsule())
                })
                .disabled(text.isEmpty)
                     
            }
            .padding()
        }
    }
}
