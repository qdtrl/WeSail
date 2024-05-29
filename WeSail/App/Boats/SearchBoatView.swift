//
//  SearchBoatView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

struct SearchBoatView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @State private var query = ""

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1)

    var body: some View {
            VStack {
                if boatsVM.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.black)
                        .opacity(0.6)
                        .accessibility(identifier: "loading")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(boatsVM.boatsSearched) { boat in
                                NavigationLink(destination: BoatView(boatId: boat.id)) {
                                    BoatRow(boat: boat)
                                        .frame(maxWidth: .infinity, minHeight: 300)
                                        .accessibility(identifier: "boatSearchCell")
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .accessibility(identifier: "boatsSearchedGrid")
                        .searchable(text: $query)
                        .onChange(of: query) { newValue in
                            boatsVM.search(query: newValue)
                        }
                        .navigationTitle("Bateaux")
                    }
                    .foregroundColor(.black)
                        
                }
            }
            .onAppear {
                query = ""
            }
    }
}
