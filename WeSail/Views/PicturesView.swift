//
//  PicturesView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct PicturesView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 3)], spacing: 3) {
            ForEach(0 ..< 100) { _ in
                Image(systemName: "sailboat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .background(.blue.opacity(0.2))
                    .clipped()
            }
        }
    }
}

#Preview {
    ScrollView {
        PicturesView()
    }
}
