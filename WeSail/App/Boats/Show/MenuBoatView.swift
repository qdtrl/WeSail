//
//  MenuBoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 12/02/2024.
//

import SwiftUI

struct MenuBoatView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @State var boat: Boat

    var body: some View {
        List {
            Section("Bateaux") {
                NavigationLink(destination: UpdateBoatView(boat: boat)) {
                    SettingsRowView(imageName: "pencil", title: "Modifier", tintColor: Color(.systemGray))
                }
            }
        }
        .navigationTitle(boat.name)
        
        
    }
}

//#Preview {
//    MenuBoatView(boat: BoatsViewModel().mockData[0])
//}
