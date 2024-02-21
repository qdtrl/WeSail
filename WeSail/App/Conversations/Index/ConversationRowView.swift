//
//  ConversationRowView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/02/2024.
//

import SwiftUI

struct ConversationRowView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 20) {
            UserImageView(image: conversation.image, width: 50)

            ZStack {
                if let lastMessage = conversation.messages?.last {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(conversation.name)
                                .bold()
                            Spacer()
                            
                            Text("\((lastMessage.date.descriptiveString()))")
                        }
                        
                        HStack {
                            Text((lastMessage.text))
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                        }
                    }
                    Circle()
                        .foregroundColor(lastMessage.isRead ? .clear : .blue)
                        .frame(width: 14, height: 14)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(conversation.name)
                                .bold()
                            Spacer()
                        }
                        
                        HStack {
                            Text("Aucun message")
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                        }
                    }
                }
            }
        }
        .frame(height: 70)
        .accessibility(identifier: "chatCell")
    }
}

