//
//  BoatsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct BoatsView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1)

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
                    default:
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(boatsVM.boats) { boat in
                                    NavigationLink(value: boat) {
                                        BoatRow(boat: boat)
                                            .frame(maxWidth: .infinity, minHeight: 300)
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
                
                Spacer()
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
            AsyncImage(url: URL(string: boat.image)) { phase in
                switch phase {
                case .empty:
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.gray)
                            .opacity(0.2)   
                            .accessibility(identifier: "loadingImage")   
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .clipped()
                case .failure(_):
                    Color.red.opacity(0.2)
                @unknown default:
                    Color.yellow.opacity(0.2)
                }
            }       
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                      
            VStack(alignment: .leading) {
                HStack {
                    Text(boat.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(boat.number)")
                        .font(.subheadline)
                }
                
                HStack {
                    Text(boat.club)
                        .font(.subheadline)
                    
                    Spacer()

                    Text(boat.type)
                        .font(.subheadline)
                }

                Text("\(boat.crew?.count ?? 0) membres")
                        .font(.subheadline)
            }
        }
    }
}

//#Preview {
//    BoatsView()
//}
