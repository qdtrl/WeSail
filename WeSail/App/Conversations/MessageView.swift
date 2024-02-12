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
        return message.user.id == "1"
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
                
                }
                .padding(.trailing, 5)
            } else {
                HStack(alignment: .top) {
                    UserImageView(image: message.user.image, width: 40)

                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(message.user.firstName) \(message.user.lastName)")
                        Text(message.text)
                            .padding(10)
                            .background(.green)
                            .opacity(0.9)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                .padding(.leading, 5)
                Spacer()
            }
        }
        .id(message.id)
    }
}

#Preview {
    MessageView(message: Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: Date(), isRead: false))
}
