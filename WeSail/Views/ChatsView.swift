//
//  RoomView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import SwiftUI

struct ChatsView: View {
    @StateObject var chatsModel = ChatsModel()
    @State private var query = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(chatsModel.mockData) { chat in
                    ZStack {
                        ChatRow(chat: chat)
                        
                        NavigationLink(destination: {
                            ChatView(chat: chat)
                                .environmentObject(chatsModel)
                        }) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(action: {
                            chatsModel.markAsRead(!chat.messages.last!.isRead, chat: chat)
                        }) {
                            if chat.messages.last!.isRead {
                                Label("Non lu", systemImage: "cicle.fill")
                            } else {
                                Label("Lu", systemImage: "text.bubble")
                            }
                        }
                        .tint(.blue)
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
            
        }
        
    }
}

struct ChatRow: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: chat.image), transaction: .init(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .opacity(0.2)
                        .transition(.opacity.combined(with: .scale))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .transition(.opacity.combined(with: .scale))
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
                        Text(chat.name)
                            .bold()
                        Spacer()
                        
                        Text("\(chat.messages.last!.date.descriptiveString())")
                    }
                    
                    HStack {
                        Text(chat.messages.last!.text)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .frame(height: 50, alignment: .top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 40)
                    }
                }
                Circle()
                    .foregroundColor(chat.messages.last!.isRead ? .clear : .blue)
                    .frame(width: 14, height: 14)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 70)
    }
}

#Preview {
    ChatsView()
}
