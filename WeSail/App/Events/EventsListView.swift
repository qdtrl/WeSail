//
//  EventsView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct EventsListView: View {
    @State var events: [Event]
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .top), count: 1)
    
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
                LazyVGrid(columns: columns) {
                    ForEach(events) { event in
                        EventView(event: event)
                            .accessibility(identifier: "eventUserCell")
                        
                    }
                }
                .accessibility(identifier: "eventsGrid")
            }
            .foregroundColor(.black)
        }
    }
}
