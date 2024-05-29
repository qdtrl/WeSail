//
//  AddBoatEvent.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct AddBoatEvent: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    
    @Environment(\.dismiss) var dismiss

    @State var boat: Boat

    @State private var name: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Nom de l'événement", text: $name)

                   DatePicker("Date de début", selection: $startDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                   DatePicker("Date de fin", selection: $endDate, displayedComponents: [.date]).datePickerStyle(.graphical)

                }
                Section {
                    Button("Créer l'événement") {
                       Task {
                          let event = Event(
                           id: UUID().uuidString,
                           name: name,
                           startDate: startDate,
                           endDate: endDate,
                           createdAt: Date(),
                           participants: [])
                                            
                          try await boatsVM.addEventToBoat(boat, event)
                            
                          dismiss()
                       }
                    }
                }
            }
        }
        .navigationTitle("Nouvel événement")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Retour")
            }
        )

    }
}
