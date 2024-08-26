//
//  RouterView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 15/01/2024.
//

import SwiftUI

struct RouterView: View {
    @EnvironmentObject var authService: AuthService

    @StateObject var boatsVM = BoatsViewModel()
    @StateObject var boatVM = BoatViewModel()
    @StateObject var eventsVM = EventsViewModel()
    @StateObject var conversationsVM = ConversationsViewModel()
    @StateObject var usersVM = UserViewModel()

    var body: some View {
        Group {
            if authService.userSession != nil, authService.currentUser != nil, let user = authService.currentUser {
                TabView {
                    NavigationStack {
                        BoatsView()
                    }
                    .tabItem {
                        Image(systemName: "sailboat")
                            .accessibility(identifier: "boatsTab")
                    }
                    
                    NavigationStack {
                        ConversationsView()
                    }
                    .tabItem {
                        Image(systemName: "message")
                            .accessibility(identifier: "chatsTab")
                    }
                        
                    
                    NavigationStack {
                        ProfileView(userId: user.id, currentUser: user)
                    }
                    .tabItem {
                        Image(systemName: "person")
                            .accessibility(identifier: "profileTab")
                    }
                }
                .environmentObject(boatsVM)
                .environmentObject(boatVM)
                .environmentObject(eventsVM)
                .environmentObject(conversationsVM)
                .environmentObject(usersVM)
            } else {
                LoginView()
            }
        }
    }
}
