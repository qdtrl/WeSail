//
//  MenuBoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 12/02/2024.
//

import SwiftUI

struct MenuBoatView: View {
    @EnvironmentObject var boatVM: BoatViewModel

    var body: some View {
        List {
            Section("Bateaux") {
                NavigationLink(destination: UpdateBoatView().environmentObject(boatVM)) {
                    SettingsRowView(imageName: "pencil", title: "Modifier", tintColor: Color(.systemGray))
                }
            }
        }
        .navigationTitle(boatVM.boat!.name)
        
        
    }
}

//#Preview {
//    MenuBoatView(boat: BoatsViewModel().mockData[0])
//}
