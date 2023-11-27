//
//  ContentView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated:Bool = false

    var body: some View {
        if isAuthenticated {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "popcorn")
                        Text("Accueil")
                    }
                
                BoatsView()
                    .tabItem {
                        Image(systemName: "sailboat")
                        Text("Yacht")
                    }
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("Message")
                    }
                
                ProfileView()
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
