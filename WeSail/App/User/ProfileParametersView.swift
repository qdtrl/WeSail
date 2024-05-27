//
//  ProfileParametersView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct ProfileParametersView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        List {
            Section {
                
            }
            
            Section("Générale") {
                SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
            }
            
            Spacer()
            
            Button {
                authService.signOut()
            } label: {
                SettingsRowView(imageName: "arrow.left.circle.fill", title: "Déconnection", tintColor: .red)
            }
            
        }
    }
}

#Preview {
    ProfileParametersView()
}
