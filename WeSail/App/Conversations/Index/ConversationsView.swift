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
                    ConversationRowView(conversation: conversation)
                    
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CreateConversationView()) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .accessibility(identifier: "conversationsList")
        .onAppear() {
            conversationsVM.index()
        }
    }
}

