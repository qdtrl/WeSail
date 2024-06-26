//
//  RoomView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 01/12/2023.
//

import SwiftUI
import Firebase

struct ConversationsView: View {
    @EnvironmentObject var conversationsVM: ConversationsViewModel
    @EnvironmentObject var authService: AuthService
    @State private var query = ""

    var body: some View {
        List {
            if conversationsVM.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .accessibility(identifier: "loading")
            } else {
                if conversationsVM.conversationsSearch.isEmpty {
                    Text("Aucune conversation trouvée")
                        .foregroundColor(.black)
                        .opacity(0.6)
                } else {
                    ForEach($conversationsVM.conversationsSearch) { conversation in
                        ZStack {
                            ConversationRowView(conversation: conversation.wrappedValue)
                            
                            NavigationLink(destination: {
                                ConversationView(conversationId: conversation.id)
                            }) {
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 0)
                            .opacity(0)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(action: {
                                conversationsVM.markLastMessageAsRead(conversation: conversation.wrappedValue)
                            }) {
                                if conversation.wrappedValue.lastMessage.isRead {
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
        .refreshable {
            conversationsVM.index(userId: authService.currentUser!.id)
        }
        .onChange(of: query) { newValue in
            conversationsVM.search(query: newValue)
        }
        .onAppear() {
            if let curUs = authService.currentUser {
                conversationsVM.index(userId: curUs.id)

            }
            Analytics.logEvent(AnalyticsEventScreenView, 
            parameters: [AnalyticsParameterScreenName: "\(ConversationsView.self)",
                        AnalyticsParameterScreenClass: "\(ConversationsView.self)"])
        }
        .onDisappear {
            conversationsVM.stopListening()
        }
    }
}

