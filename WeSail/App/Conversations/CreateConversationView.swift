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
    @EnvironmentObject var authService: AuthService

    @State var name = ""
    @State var users: [User] = []
    @State var image = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                InputView(
                    text: $name,
                    title: "Nom",
                    placeHolder: "Nom de la conversation"
                )

                InputView(
                    text: $image,
                    title: "Image",
                    placeHolder: "URL de l'image"
                )
                
                Spacer()
                    
                Button(action: {
                    let conversation = Conversation(
                        id: UUID().uuidString,
                        name: name,
                        image: "https://www.manche.fr/wp-content/uploads/2023/03/manche-sport-evidence-nautique-cd50-ddaguier-04.jpg",
                        users: users + [authService.currentUser!]
                    )
                    
                    Task {
                        conversationsVM.create(conversation)
                    }

                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Ajouter")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.vertical, 20)
                
            }
            .padding(.horizontal, 20)
            
        }
        .navigationBarTitle("Nouvelle conversation", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Retour")
            }
        )
        
    }
}
