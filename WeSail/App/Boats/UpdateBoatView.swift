//
//  UpdateBoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 11/02/2024.
//

import SwiftUI
import UIKit

struct UpdateBoatView: View {
    @EnvironmentObject var boatVM: BoatViewModel
    
    @Environment(\.dismiss) var dismiss

    @State var boat: Boat
    
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    @State private var name: String = ""
    @State private var type: String = ""
    @State private var number: String  = ""
    @State private var club: String  = ""
    @State private var image: String = ""

    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        if let inputImage = inputImage {
                            Image(uiImage: inputImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .scaledToFill()
                                 .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            
                        } else {
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
                                    .frame(height: 200)
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
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        self.showingImagePicker = true
                    }

                    TextField("Nom", text: $name)
                    
                    TextField("Type", text: $type)
                    
                    TextField("Numéro", text: $number)
                    
                    TextField("Club", text: $club)
                }

                Button {
                    Task {
                        let boat = Boat(id: self.boat.id, name: name, type: type, number: number, club: club, image: image, owners: self.boat.owners, crew: self.boat.crew, images: self.boat.images)
                        
                        boatVM.update(boat: boat, image: inputImage ?? UIImage())
                        
                        self.dismiss()
                        
                    }
                } label: {
                    if boatVM.isLoading {
                        ProgressView()
                    } else {
                        Text("Mettre à jour")
                    }
                }
                .disabled(boatVM.isLoading)
            }
        }        
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .onAppear {
            self.name = boat.name
            self.type = boat.type
            self.number = boat.number
            self.club = boat.club
            self.image = boat.image
        }
    }
}
