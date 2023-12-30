//
//  EventsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var eventsModel = EventsViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(eventsModel.mockData) { event in
                NavigationLink(value: event) {
                    EventRow(event: event)
                        .accessibility(identifier: "eventCell")
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
        }
        .padding(.horizontal)
        .accessibility(identifier: "eventsList")
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: event.images!.first!), transaction: .init(animation: .spring())) { phase in
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
                .frame(width: 60)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                VStack(alignment: .leading) {
                    Text(event.name)
                        .font(.title2)
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

            switch event.status {
            case "start":
                ProvisoryResultsRace(race: event.races![0])
            case "end":
                ResultsRace(race: event.races![0])
            default:
                EmptyView()
            }
            
            Divider()
                .padding(.horizontal, 16)
                .background(Color.gray)
        }
        .foregroundColor(.black)
    }
}
struct ProvisoryResultsRace: View {
    let race: Race
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Classement provisoire :")
                    .font(.caption)
                
                Spacer()
                
                Text("\(race.date.descriptiveString())")
                    .font(.caption2)
            }
            
            VStack {
                ForEach(0 ..< 3) { index in
                    HStack {
                        Text("\(race.results![index].name)")
                        
                        Spacer()
                        
                        Text("01:4\(3*index):02:427")
                            .font(.caption)
                    }
                    
                }
            }
        }
    }
}

struct ResultsRace: View {
    let race: Race
    
    var body: some View {
        HStack {
            VStack {
                AsyncImage(url: URL(string: race.results![1].image), transaction: .init(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                       ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.gray)
                            .opacity(0.2)
                    case .success(let image):
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    
                    case .failure(_):
                        Color.red.opacity(0.2)
                    @unknown default:
                        Color.yellow.opacity(0.2)
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                Text(race.results![1].name)
                    .font(.subheadline)
                    .bold()
                
                Image(systemName: "trophy.fill")
                    .foregroundColor(Color("Silver"))
            }
            .padding(.top, 10)
            .frame(width: 100)
            
            Spacer()
            
            VStack {
                AsyncImage(url: URL(string: race.results![0].image), transaction: .init(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.gray)
                            .opacity(0.2)
                        
                    case .success(let image):
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    
                    case .failure(_):
                        Color.red.opacity(0.2)
                    @unknown default:
                        Color.yellow.opacity(0.2)
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                Text(race.results![0].name)
                    .font(.subheadline)
                    .bold()
                
                Image(systemName: "trophy.fill")
                    .foregroundColor(Color("Gold"))
            }
            .padding(.bottom, 10)
            .frame(width: 100)

            Spacer()
            
            VStack {
                AsyncImage(url: URL(string: (race.results?[2].image)!), transaction: .init(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                       ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.gray)
                            .opacity(0.2)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                    case .failure(_):
                        Color.red.opacity(0.2)
                    @unknown default:
                        Color.yellow.opacity(0.2)
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                Text(race.results![2].name)
                    .font(.subheadline)
                    .bold()
                
                Image(systemName: "trophy.fill")
                    .foregroundColor(Color("Bronze"))
            }
            .frame(width: 100)
            .padding(.top, 20)
        }
    }
}

//#Preview {
//    EventsView()
//}
