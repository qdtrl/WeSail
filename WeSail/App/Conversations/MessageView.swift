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
                    AsyncImage(url: URL(string: message.user.image!), transaction: .init(animation: .spring())) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.gray)
                                .opacity(0.2)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .scaledToFill()
                        case .failure(_):
                            Color.red.opacity(0.2)
                        @unknown default:
                            Color.yellow.opacity(0.2)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
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
