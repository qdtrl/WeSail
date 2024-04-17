//
//  WeSailApp.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WeSailApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authService = AuthService()
    @StateObject var boatsVM = BoatsViewModel()
    @StateObject var conversationsVM = ConversationsViewModel()
    @StateObject var usersVM = UserViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
                .environmentObject(boatsVM)
                .environmentObject(conversationsVM)
                .environmentObject(usersVM)
        }
    }
}
