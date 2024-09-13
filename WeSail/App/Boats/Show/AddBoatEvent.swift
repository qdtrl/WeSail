//
//  AddBoatEvent.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct AddBoatEvent: View {
    @EnvironmentObject var eventsVM: EventsViewModel
    @EnvironmentObject var boatVM: BoatViewModel
   
    @Environment(\.dismiss) var dismiss

    @State var boat: Boat

    @State private var name: String = ""
    @State private var startDate: Date?
    @State private var endDate: Date?

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Nom de l'événement", text: $name)
                    if let startDate = startDate {
                        DatePicker("Date de début", selection: Binding(get: { startDate }, set: { self.startDate = $0 }), displayedComponents: [.date])
                    }
                    if let endDate = endDate {
                        DatePicker("Date de fin", selection: Binding(get: { endDate }, set: { self.endDate = $0 }), displayedComponents: [.date])
                    }
                }
                Section {
                    Button("Créer l'événement") {
                       Task {
                          let event = Event(
                            id: UUID().uuidString,
                            boatId: boat.id,
                            name: name,
                            startDate: startDate ?? Date.now,
                            endDate: endDate ?? Date.now,
                            createdAt: Date.now,
                            participants: [])
                                         
                            eventsVM.create(event: event) { event in
                                DispatchQueue.main.async {
                                    boatVM.events.append(event)
                                }
                                dismiss()
                            }
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
        .onAppear {
            self.startDate = Date()
            self.endDate = Date()
        }

    }
}
