//
//  BoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct BoatView: View {
    @State var id: String
    @State var index = 0

    @StateObject var boatVM: BoatViewModel
    @EnvironmentObject var authService: AuthService
    
    @Environment(\.dismiss) var dismiss

    private init(id: String, boatVM: BoatViewModel) {
        self._id = State(initialValue: id)
        self._boatVM = StateObject(wrappedValue: boatVM)
    }

    init(id: String) {
        self.init(id: id, boatVM: BoatViewModel(id: id))
    }

    var body: some View {
        ZStack {
            if boatVM.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .accessibility(identifier: "loading")
            } else if let boat = boatVM.boat {
                NavigationStack {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    AsyncImage(url: URL(string: boat.image), transaction: .init(animation: .spring())) { phase in
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
                                    .frame(width: 140, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                    
                                    Spacer()
                                    VStack {
                                        Text("\(boatVM.events.count)")
                                            .bold()
                                        Text("Evènements")
                                    }
                                    Spacer()
                                    VStack {
                                        Text("\(boat.crew.count)")
                                            .bold()
                                        Text("Membres")
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(boat.name)
                                            .bold()
                                        Spacer()
                                        Text("Type : \(boat.type)")
                                    }
                                    HStack {
                                        Text("\(boat.number)")
                                            .font(.caption)
                                        Spacer()
                                        Text("Club: \(boat.club)")
                                    }
                                }
                                if let curUs = authService.currentUser {
                                    if boat.crew.contains(curUs.id) {
                                        HStack {
                                            Spacer()
                                            
                                            NavigationLink(destination: AddBoatImageView().environmentObject(boatVM)) {
                                                Text("+ Image")
                                            }
                                            .frame(width: 120)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .foregroundColor(.black)
                                            .background(.thickMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                            
                                            Spacer()
                                            
                                            NavigationLink(destination: AddBoatEvent(boat: boat).environmentObject(boatVM)) {
                                                Text("+ Evènement")
                                            }
                                            .frame(width: 120)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .foregroundColor(.black)
                                            .background(.thickMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                            
                                            Spacer()
                                        }
                                    } else {
                                        HStack {
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                Task {
                                                    boatVM.joinBoat(user: curUs)
                                                }
                                            }) {
                                                Text("Rejoindre")
                                            }
                                            .frame(width: 120)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .foregroundColor(.black)
                                            .background(.thickMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                
                                
                                
                                HStack {
                                    VStack {
                                        Button(action: {
                                            self.index = 0
                                        }) {
                                            Image(systemName: "calendar")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(index == 0 ? .black : .gray)
                                        }
                                        .accessibility(identifier: "eventsButton")
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(index == 0 ? .black : .gray)
                                    }
                                    
                                    
                                    
                                    VStack {
                                        Button(action: {
                                            self.index = 1
                                        }) {
                                            Image(systemName: "camera")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(index == 1 ? .black : .gray)
                                        }
                                        .accessibility(identifier: "picturesButton")
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(index == 1 ? .black : .gray)
                                    }
                                    
                                    
                                    
                                    VStack {
                                        Button(action: {
                                            self.index = 2
                                        }) {
                                            Image(systemName: "person.2")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(index == 2 ? .black : .gray)
                                        }
                                        .accessibility(identifier: "crewButton")
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(index == 2 ? .black : .gray)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            switch index {
                            case 0:
                                EventsListView(events: $boatVM.events)
                            case 1:
                                PicturesView(pictures: boat.images)
                            case 2:
                                CrewView(crew: $boatVM.crew)
                            default:
                                Text("Pas d'évènements")
                                    .padding(.vertical, 20)
                            }
                        }
                }
                .refreshable {
                    boatVM.show()
                }
                .accessibility(identifier: "boatView")
                .toolbar {
                    if let userAuth = authService.currentUser {
                        if boat.owners.contains(userAuth.id) {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: MenuBoatView(boat: boat)) {
                                    Image(systemName: "ellipsis")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
