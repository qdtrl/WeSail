//
//  PicturesView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct PicturesView: View {
    @State var pictures: [String]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 3)], spacing: 3) {
            ForEach(pictures, id: \.self) { picture in
                AsyncImage(url: URL(string: picture)) { phase in
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
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .clipped()
                    case .failure(_):
                        Color.red.opacity(0.2)
                    @unknown default:
                        Color.yellow.opacity(0.2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .accessibility(identifier: "picturesGrid")
    }
}

//#Preview {
//    ScrollView {
//        PicturesView()
//    }
//}
