//
//  RoomView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import SwiftUI

struct ConversationsView: View {
    @EnvironmentObject var conversationsVM: ConversationsViewModel
    @State private var query = ""

    var body: some View {
        List {
            ForEach(conversationsVM.conversations) { conversation in
                ZStack {
                    ConversationRow(conversation: conversation)
                    
                    NavigationLink(destination: {
                        ConversationView(conversation: conversation)
                    }) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 0)
                    .opacity(0)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(action: {
//                        Message is read
                    }) {
                        if ((conversation.messages?.last!.isRead) != nil) {
                            Label("Non lu", systemImage: "cicle.fill")
                        } else {
                            Label("Lu", systemImage: "text.bubble")
                        }
                    }
                    .tint(.blue)
                    .accessibility(identifier: "readLastMessage")
                }
            }
        }
        .listStyle(PlainListStyle())
        .searchable(text: $query)
        .navigationBarTitle("Conversations")
        .navigationBarItems(trailing: Button(action: {
            print("Add room")
        }, label: {
            Image(systemName: "square.and.pencil")
        }))
        .accessibility(identifier: "chatsList")
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: conversation.image), transaction: .init(animation: .spring())) { phase in
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
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(conversation.name)
                            .bold()
                        Spacer()
                        
                        Text("\((conversation.messages?.last!.date.descriptiveString())!)")
                    }
                    
                    HStack {
                        Text((conversation.messages?.last!.text)!)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .frame(height: 50, alignment: .top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 40)
                    }
                }
                Circle()
                    .foregroundColor(((conversation.messages?.last!.isRead) != nil) ? .clear : .blue)
                    .frame(width: 14, height: 14)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 70)
        .accessibility(identifier: "chatCell")
    }
}

//#Preview {
//    ChatsView()
//}
