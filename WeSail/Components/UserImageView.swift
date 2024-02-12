//
//  UserImageView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 12/02/2024.
//

import SwiftUI

struct UserImageView: View {
    @State var image: String
    @State var width: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
            .foregroundColor(.gray)
            .opacity(0.2)
            if (image != "") {   
                AsyncImage(url: URL(string: image)) { phase in
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
                            .scaledToFill()
                    case .failure(_):
                        Color.red.opacity(0.2)
                    @unknown default:
                        Color.yellow.opacity(0.2)
                    }
                }
            } else {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: width - width * 0.3, height: width - width * 0.3)
            }
        }
        .frame(width: width, height: width)
        .clipShape(Circle())
    }
}

#Preview {
    UserImageView(image: "", width: 50)
}
