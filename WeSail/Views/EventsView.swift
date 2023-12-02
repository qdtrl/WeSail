//
//  EventsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var eventsModel = EventsModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(eventsModel.mockData) { event in
                    NavigationLink(destination: EventView(event: event)) {
                        EventRow(event: event)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: event.images.first!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 60)
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title)
                    .bold()
                
                Text(event.organizer)
                    .font(.subheadline)
                    .bold()
                
                HStack(spacing: 3) {
                    Text("du")
                    
                    Text(event.startDate, style: .date)
                        .foregroundColor(.black)
                    
                    Text("au")
                    
                    Text(event.endDate, style: .date)
                        .foregroundColor(.black)
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
        }
    }
}   

#Preview {
    EventsView()
}
