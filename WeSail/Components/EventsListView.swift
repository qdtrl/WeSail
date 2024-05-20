//
//  EventsView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct EventsListView: View {
    @State var events: [Event]

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1)
    
    var body: some View {
        if events.isEmpty {
            VStack {
                Spacer()
                Text("Aucun événement")
                    .font(.title)
                    .foregroundColor(.gray)
                Spacer()
            }
        } else {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(events) { event in
                        EventRow(event: event)
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .accessibility(identifier: "eventUserCell")
                        
                    }
                }
                .padding(.horizontal, 10)
                .accessibility(identifier: "eventsGrid")
            }
            .foregroundColor(.black)
        }
    }
}
