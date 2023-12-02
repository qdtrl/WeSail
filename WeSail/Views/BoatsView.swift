//
//  BoatsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct BoatsView: View {
    @StateObject var boatsModel = BoatsModel()

    var body: some View {
        switch boatsModel.mockData.count {
        case 0:
            Text("Ajoutez un bateau ou rejoignez un équipage")
                .multilineTextAlignment(.center)
        case 1:
            BoatView(boat: boatsModel.mockData[0])
        default:
            NavigationView {
                List {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))], spacing: 20) {
                        ForEach(boatsModel.mockData) { boat in
                            ZStack {
                                BoatRow(boat: boat)
                                NavigationLink(destination: {
                                    BoatView(boat: boat)
                                        .environmentObject(boatsModel)
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
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct BoatRow:View {
    let boat: Boat

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: boat.boatImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            VStack(alignment: .leading) {
                HStack {
                    Text(boat.boatName)
                        .font(.headline)
                        
                    Spacer()
                    
                    Text("Class 10")
                        .font(.subheadline)
                }
                HStack {
                    Text("19756")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("\(boat.crew.count) membres")
                        .font(.subheadline)
                }
            }.padding(.horizontal)
        }
        .frame(height: 200)
    }
}

#Preview {
    BoatsView()
}
