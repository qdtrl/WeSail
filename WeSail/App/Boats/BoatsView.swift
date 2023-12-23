//
//  BoatsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct BoatsView: View {
    @StateObject var boatsModel = BoatsModel()
    @State var boats: [Boat]

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 2)

    var body: some View {
        switch boats.count {
        case 0:
            Text("Ajoutez un bateau ou rejoignez un équipage")
                .multilineTextAlignment(.center)
                .accessibility(identifier: "noBoat")
        case 1:
            BoatView(boat: boats[0])
        default:
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(boats) { boat in
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

struct BoatRow:View {
    let boat: Boat

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: boat.image), transaction: .init(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    Color.gray
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
                    
                    Text("\(boat.crew.count) membres")
                        .font(.subheadline)
                }
            }
        }
    }
}

//#Preview {
//    BoatsView(boats: BoatsModel().mockData)
//}
