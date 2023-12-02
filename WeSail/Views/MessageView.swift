//
//  MessageView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var isFromCurrentUser: Bool {
        return message.userId == "1"
    }

    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                HStack(alignment: .top) {
                    Text(message.text)
                        .padding(10)
                        .background(.blue)
                        .opacity(0.9)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    Image(systemName: message.userImage)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                }
            } else {
                HStack(alignment: .top) {
                    Image(systemName: message.userImage)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 0) {
                        Text(message.userName)
                        Text(message.text)
                            .padding(10)
                            .background(.green)
                            .opacity(0.9)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                Spacer()
            }
        }
        .id(message.id)
    }
}

#Preview {
    MessageView(message: Message(userId: "2", userName: "Robert Gandhi", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"))
}
