//
//  PicturesView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct PicturesView: View {
    @State var pictures: [String] 
        
    @State private var selectedImage: String? = nil
    @State private var isShowingFullScreenImage = false
    
    var body: some View {
        if pictures.isEmpty {
            VStack {
                Spacer()
                Text("Aucune photo")
                    .font(.title)
                    .foregroundColor(.gray)
                Spacer()
            }
        } else {
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
                            .frame(height: 160)
                            .background(Color.gray.opacity(0.2))
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: nil, minHeight: 160, maxHeight: 160)
                                .clipped()
                                .onTapGesture {
                                    selectedImage = picture
                                    isShowingFullScreenImage = true
                                }
                        case .failure(_):
                            Color.red.opacity(0.2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 160)
                        @unknown default:
                            Color.yellow.opacity(0.2)
                        }
                    }
                }
            }
            .accessibility(identifier: "picturesGrid")
            .sheet(isPresented: $isShowingFullScreenImage) {
                if let selectedImage = selectedImage, let url = URL(string: selectedImage) {
                    AsyncImage(url: url) { phase in
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
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(_):
                            Color.red.opacity(0.2)
                        @unknown default:
                            Color.yellow.opacity(0.2)
                        }
                    }
                }
            }
        }
    }
}
