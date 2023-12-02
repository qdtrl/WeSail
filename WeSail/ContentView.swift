//
//  ContentView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated:Bool = true
    @State var user: User

    var body: some View {
        if isAuthenticated {
            TabView {
                EventsView()
                    .tabItem {
                        Image(systemName: "popcorn")
                        Text("Accueil")
                    }
                
                BoatsView()
                    .tabItem {
                        Image(systemName: "sailboat")
                        Text("Yacht")
                    }
                
                ChatsView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("Message")
                    }
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profil")
                    }
            }

        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView(isAuthenticated: true, user: User(id: UUID(), userId: "1", email: "quentindtouroul@gmail.com", firstName: "Quentin", lastName: "Touroul"))
}
