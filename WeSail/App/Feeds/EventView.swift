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
                        ForEach(event.images!, id: \.self) { image in
                            AsyncImage(url: URL(string: image), transaction: .init(animation: .spring())) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .foregroundColor(.gray)
                                        .opacity(0.2)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                case .failure(_):
                                    Color.red.opacity(0.2)
                                @unknown default:
                                    Color.yellow.opacity(0.2)
                                }
                            }
                            .frame(height: 140)
                            .frame(minWidth: 80)
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

                Text("Participants  (\(event.participants!.count))")
                    .font(.title2)
                    .bold()
                    .padding(.top, 10)
            }
            .padding()

            BoatsView()
        }
    }
}

//#Preview {
//    EventView(
//        event: EventsModel().mockData[0]
//    )
//}
