//
//  BoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct BoatView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @State var boat: Boat
    @State var index = 0

    var body: some View {
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
                        Text("\(boat.events.count)")
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

                if boat.crew.contains(authService.currentUser!.id) {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: AddBoatImageView(boat: boat)) {
                            Text("+ Image")
                        }
                        .frame(width: 120)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(.black)
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                        Spacer()
                        
                        NavigationLink(destination: AddBoatEvent(boat: boat)) {
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
                        
                        Button(action: {}) {
                            Text("Suivre")
                        }
                        .frame(width: 120)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(.black)
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                        Spacer()
                        
                        Button(action: {}) {
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
                if boat.events.count > 0 {
                    EventsView()
                } else {
                    Text("Pas d'évènements")
                        .padding(.vertical, 20)
                }
            case 1:
                if boat.images.count > 0 {
                    PicturesView(pictures: boat.images)
                    .background(Color.gray.opacity(0.2))
                } else {
                    Text("Pas d'images")
                        .padding(.vertical, 20)
                }
            case 2:
                if boat.crew.count > 0 {
//                    CrewView(crewIds: crew)
                } else {
                    Text("Pas de membres")
                        .padding(.vertical, 20)
                }
            default:
                Text("Pas d'évènements")
                    .padding(.vertical, 20)
            }
        }
        .onAppear()
        .accessibility(identifier: "boatView")
        .toolbar {
            if boat.owners.contains(authService.currentUser!.id) {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MenuBoatView(boat: boat)) {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

//#Preview {
//    BoatView(boat: BoatsViewModel().mockData[0])
//}
