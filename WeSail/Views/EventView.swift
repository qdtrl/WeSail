//
//  EventView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct EventView: View {
    let event: Event
    
    var body: some View {
        ScrollView(showsIndicators: false) {
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
                
                HStack {
                    Text("Rang: \(event.type)")
                    
                    Spacer()
                    
                    Text("20 inscrits")

                }
                .font(.caption)
                .bold()
                .padding(.top, 10)
                
                Text(event.description)
                    .font(.body)
                    .padding(.top, 10)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.flexible(minimum: 140, maximum: 150))]) {
                        ForEach(event.images, id: \.self) { image in
                            Image(systemName: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .background(.blue.opacity(0.2))
                                .clipped()
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Inscription")
                    }
                    .frame(width: 120)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Partager")
                    }
                    .frame(width: 120)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    Spacer()
                }

                Text("Participants  (\(BoatsModel().mockData.count))")
                    .font(.title2)
                    .bold()
                    .padding(.top, 10)

                    // Boat List

                

                
                
            }
            .padding()

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))], spacing: 20) {
                ForEach(BoatsModel().mockData) { boat in
                    ZStack {
                        BoatRow(boat: boat)
                        NavigationLink(destination: {
                            BoatView(boat: boat)
                                .environmentObject(BoatsModel())
                            }) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                    }
                }
            }
        }
    }
}

#Preview {
    EventView(
        event: Event(
            eventId: "1",
            name: "Les Voiles de Saint-Tropez",
            organizer: "Société Nautique de Saint-Tropez",
            description: "Les Voiles de Saint-Tropez is a regatta held annually the last week of September on the Mediterranean around the gulf of Saint-Tropez, France. It is one of the largest regattas in the world with over 300 modern and classic sailing yachts racing over a week.",
            type: "Classique",
            images: ["sailboat", "sailboat1", "sailboat2"],
            startDate: Date(),
            endDate: Date()
        )
    )
}
