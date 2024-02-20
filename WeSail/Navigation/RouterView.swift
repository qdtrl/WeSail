//
//  RouterView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 15/01/2024.
//

import SwiftUI

struct RouterView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        Group {
            if $authService.userSession != nil, authService.currentUser != nil, let user = authService.currentUser {
                TabView {
                    NavigationStack {
                        FeedsView()
                    }
                    .tabItem {
                        Image(systemName: "popcorn")
                            .accessibility(identifier: "eventsTab")
                    }
                    
                    NavigationStack {
                        BoatsView()
                    }
                    .tabItem {
                        Image(systemName: "sailboat")
                            .accessibility(identifier: "boatsTab")
                    }
                    
                    NavigationStack {
//                        ChatsView()
                    }
                    .tabItem {
                        Image(systemName: "message")
                            .accessibility(identifier: "chatsTab")
                    }
                        
                    
                    NavigationStack {
                        ProfileView(userId: user.id)
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
