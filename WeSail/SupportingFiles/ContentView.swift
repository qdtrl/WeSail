//
//  ContentView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.userSession != nil {
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
                        ProfileView()
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
}

#Preview {
    ContentView()
}
