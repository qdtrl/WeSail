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
            AsyncImage(url: URL(string: event.images.first!), transaction: .init(animation: .spring())) { phase in
                                     switch phase {
                                     case .empty:
                                         Color.gray
                                         .opacity(0.2)
                                         .transition(.opacity.combined(with: .scale))
                                     case .success(let image):
                                       image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .transition(.opacity.combined(with: .scale))
                                     case .failure(_):
                                         Color.red.opacity(0.2)
                                     @unknown default:
                                         Color.yellow.opacity(0.2)
                                     }
                                   }
                                    .frame(width: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

            
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
