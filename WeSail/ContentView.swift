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
                    }
                
                BoatsView()
                    .tabItem {
                        Image(systemName: "sailboat")
                    }
                
                ChatsView()
                    .tabItem {
                        Image(systemName: "message")
                    }
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
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
