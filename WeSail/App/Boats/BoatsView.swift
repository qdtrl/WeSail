//
//  BoatsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct BoatsView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 2)

    var body: some View {
        NavigationView {
            VStack {
                if boatsVM.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.black)
                        .opacity(0.2)
                        .accessibility(identifier: "loading")
                } else {
                    switch boatsVM.boats.count {
                    case 0:
                        Text("Ajoutez un bateau ou rejoignez un équipage")
                            .multilineTextAlignment(.center)
                            .accessibility(identifier: "noBoat")
                    case 1:
                        BoatView(boat: boatsVM.boats[0])
                    default:
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(boatsVM.boats) { boat in
                                    NavigationLink(value: boat) {
                                        BoatRow(boat: boat)
                                            .frame(maxWidth: .infinity, minHeight: 200)
                                            .accessibility(identifier: "boatCell")
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .accessibility(identifier: "boatsGrid")
                            .navigationDestination(for: Boat.self) { boat in
                                BoatView(boat: boat)
                            }
                        }
                        .foregroundColor(.black)
                        
                    }
                }
            }
            .navigationTitle("Mes Bateaux")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBoatView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear() {
                boatsVM.index()
            }
        }
    }
}

struct BoatRow:View {
    let boat: Boat

    var body: some View {
        VStack(alignment: .center) {
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
                        .frame(width: 140, height: 120)
                        .frame(maxWidth: .infinity)
                        .clipped()
                case .failure(_):
                    Color.red.opacity(0.2)
                @unknown default:
                    Color.yellow.opacity(0.2)
                }
            }       
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                      
            VStack(alignment: .leading) {
                Text(boat.name)
                    .font(.headline)
                
                Text(boat.type)
                    .font(.subheadline)

                HStack {
                    Text("\(boat.number)")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("\(boat.crew?.count ?? 0) membres")
                        .font(.subheadline)
                }
            }
        }
    }
}

//#Preview {
//    BoatsView(boats: BoatsViewModel().mockData)
//}
