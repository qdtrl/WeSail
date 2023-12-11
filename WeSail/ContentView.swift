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
                NavigationStack {
                    EventsView()
                }
                .tabItem {
                    Image(systemName: "popcorn")
                        .accessibility(identifier: "eventsTab")
                }
                
                NavigationStack {
                    BoatsView(boats: BoatsModel().mockData)
                }
                .tabItem {
                    Image(systemName: "sailboat")
                        .accessibility(identifier: "boatsTab")
                }
                
                NavigationStack {
                    ChatsView()
                }
                .tabItem {
                    Image(systemName: "message")
                        .accessibility(identifier: "chatsTab")
                }
                    
                
                NavigationStack {
                    ProfileView(user: user)
                }
                .tabItem {
                    Image(systemName: "person")
                        .accessibility(identifier: "profileTab")
                }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView(isAuthenticated: true, user: UserModel().mockData[0])
}
