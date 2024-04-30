//
//  AddBoatEvent.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct AddBoatEvent: View {
    @State var boat: Boat
    @EnvironmentObject var boatsVM: BoatsViewModel
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Nouvel événement")
                .padding()
            Form {
                Section {
                    TextField("Nom de l'événement", text: $name)
                    DatePicker("Date de début", selection: $startDate, displayedComponents: .date)
                    DatePicker("Date de fin", selection: $endDate, displayedComponents: .date)
                }
                Section {
                    Button("Créer l'événement") {
                       Task {
                           try await boatsVM.addEventToBoat(boat, name, startDate, endDate)
                             
                             self.presentationMode.wrappedValue.dismiss()
                       }
                    }
                }
            }
        }
    }
}
