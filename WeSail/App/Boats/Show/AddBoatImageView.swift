//
//  AddBoatImageView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI
import FirebaseStorage
import UIKit

struct AddBoatImageView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel

    @Environment(\.dismiss) var dismiss

    @State var boat: Boat

    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            Text("Nouvelle Image")
            Spacer()
            
            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                
            } else {
                VStack {
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                    Text("Aucune image sélectionnée")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 300, height: 300)
            }
           
            VStack {
                Button("Choisir une image") {
                    self.showingImagePicker = true
                }

                Spacer()

                HStack {
                    Spacer()
                    
                    Button("Ajouter l'image") {
                        guard let image = inputImage else { return }
                        
                        Task {
                            boatsVM.uploadImageToBoat(boat, image)
                            
                            dismiss()
                        }
                    }
                    .disabled(inputImage == nil)
                    
                }
                .padding(40)

            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

