//
//  ConversationRowView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/02/2024.
//

import SwiftUI

struct ConversationRowView: View {
    @EnvironmentObject var authService: AuthService
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 20) {
            UserImageView(image: conversation.image, width: 50)

            ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(conversation.name)
                                .bold()
                            Spacer()
                            
                            Text("\((conversation.lastMessage.date.descriptiveString()))")
                        }
                        
                        HStack {
                            Text((conversation.lastMessage.text))
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                        }
                    }
                    Circle()
                        .foregroundColor(conversation.lastMessage.isRead && conversation.lastMessage.user.id != authService.currentUser!.id ? .blue : .clear)
                        .frame(width: 14, height: 14)
                        .frame(maxWidth: .infinity, alignment: .trailing)
               
            }
        }
        .frame(height: 70)
        .accessibility(identifier: "chatCell")
    }
}

