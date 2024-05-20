//
//  CreateConversationView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/02/2024.
//

import SwiftUI

struct CreateConversationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var conversationsVM: ConversationsViewModel
    @EnvironmentObject var usersVM: UserViewModel
    @EnvironmentObject var authService: AuthService
    
    @State var name = ""
    @State var message = ""
    @State var users: [User] = []
    @FocusState private var isFocused

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(usersVM.usersSearch.filter { user in user.id != authService.currentUser!.id } ) { user in
                        HStack {
                            if user.image.isEmpty {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                AsyncImage(url: URL(string: user.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                                .frame(width: 50, height: 50)
                            }
                            
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                if users.contains(user) {
                                    users = []
                                } else {
                                    users = [user]
                                }
                            }) {
                                Image(systemName: users.contains(user) ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(users.contains(user) ? .blue : .gray)
                            }
                        }
                        .padding(5)
                        
                    }
                }
                .searchable(text: $name)
                .onChange(of: name) { newValue in
                    usersVM.search(query: newValue)
                }
                
                HStack (alignment: .top) {
                    TextField("Message...", text: $message, axis: .vertical)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .focused($isFocused)
                    
                    Button(action: {
                        if !message.isEmpty {
                            guard let userConversation = users.first else { return }
                            
                            let newMessage = Message(
                                id: UUID().uuidString,
                                user: authService.currentUser!,
                                text: message,
                                date: Date(),
                                isRead: false
                            )
                            
                            let conversation = Conversation(
                                id: UUID().uuidString,
                                name: userConversation.firstName + " " + userConversation.lastName,
                                image: userConversation.image,
                                users: [userConversation.id, authService.currentUser!.id],
                                lastMessage: newMessage
                            )
                            
                            Task {
                                conversationsVM.create(conversation)
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        if conversationsVM.isLoadingMessage {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(width: 37, height: 37)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        } else {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .frame(width: 37, height: 37)
                                .background(message.isEmpty || users.isEmpty ? Color.gray : Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                    }
                    .disabled(message.isEmpty || users.isEmpty)
                }
                .padding()
            }
        }
        .navigationBarTitle("Nouvelle conversation", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Retour")
            })
        .onAppear {
            usersVM.index(userId: authService.currentUser!.id)
        }
    }
}
