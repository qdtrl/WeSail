//
//  BoatRowView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI

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

                Text("\(boat.crew.count) membres")
                        .font(.subheadline)
            }
        }
    }
}
