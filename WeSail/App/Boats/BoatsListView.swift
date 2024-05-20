//
//  BoatsListView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 14/02/2024.
//

import SwiftUI

struct BoatsListView: View {
    @State var boats: [Boat]
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(boats) { boat in
                    NavigationLink(value: boat) {
                        BoatRow(boat: boat)
                            .frame(maxWidth: .infinity, minHeight: 300)
                            .accessibility(identifier: "boatUserCell")
                    }
                }
            }
            .padding(.horizontal, 10)
            .accessibility(identifier: "boatsUserGrid")
            .navigationDestination(for: Boat.self) { boat in
                BoatView(boat: boat)
            }
        }
        .foregroundColor(.black)
    }
}
