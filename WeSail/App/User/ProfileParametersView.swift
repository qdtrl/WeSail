//
//  ProfileParametersView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct ProfileParametersView: View {
    @EnvironmentObject var authService: AuthService
    @State private var error:String = ""

    var body: some View {
        List {
            Section("Générale") {
                SettingsRowView(imageName: "gear", title: "Version 0.0.1", tintColor: Color(.systemGray))

                NavigationLink(destination: UpdateProfileView()) {
                    SettingsRowView(imageName: "person.fill", title: "Mettre à jour le profil", tintColor: .blue)
                }
            }
            
            
            Button {
                Task {
                    do {
                        try await authService.signOut()
                    } catch {
                        print("Error signing out")
                    }
                }
            } label: {
                SettingsRowView(imageName: "arrow.left.circle.fill", title: "Déconnection", tintColor: .red)
            }
            .alert(isPresented: .constant(!error.isEmpty)) {
                Alert(title: Text("Erreur"), message: Text(error), dismissButton: .default(Text("OK")) {
                    self.error = ""
                })
            }
            
        }
    }
}

#Preview {
    ProfileParametersView()
}
