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
        return message.userUid == "userUid"
    }

    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                HStack(alignment: .top) {
                    Text(message.text)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                }
            } else {
                HStack(alignment: .top) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    Text(message.text)
                        .padding(10)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MessageView(message: Message(userUid: "userUid", text: "Hello", date: Date(), isRead: false, userImage: "person.fill"))
}
