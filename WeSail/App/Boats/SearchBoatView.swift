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
                        .searchable(text: $query)
                        .navigationTitle("Bateaux")
                    }
                    .foregroundColor(.black)
                        
                }
            }
            .onAppear() {
                boatsVM.index(query: query)
            }
        
    }
}

//#Preview {
//    SearchBoatView()
//}
