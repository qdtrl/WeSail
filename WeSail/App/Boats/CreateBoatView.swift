//
//  AddBoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 24/01/2024.
//

import SwiftUI

struct CreateBoatView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @Environment(\.dismiss) var dismiss

    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    @State var name = ""
    @State var type = ""
    @State var number = ""
    @State var club = ""
    @State var image = ""

    var body: some View {
        VStack {
            Form {
                Section {
                    InputView(
                        text: $name,
                        title: "Nom",
                        placeHolder: "Nom du bateau"
                    )
                    
                    InputView(
                        text: $type,
                        title: "Type",
                        placeHolder: "Type de bateau"
                    )
                    
                    InputView(
                        text: $number,
                        title: "Numéro",
                        placeHolder: "Numéro de voile"
                    )
                    
                    InputView(
                        text: $club,
                        title: "Yacht Club",
                        placeHolder: "Club du bateau"
                    )
                }
                
                HStack {
                    if let inputImage = inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                            .frame(width: 200, height: 160)
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
                        .frame(width: 200, height: 160)
                    }
                    
                    Spacer()
                    
                    Button("Choisir une image") {
                        self.showingImagePicker = true
                    }
                    .font(.headline)
                }

                HStack {
                    Spacer()
                
                    Button(action: {
                        guard let image = inputImage else { return }
                        
                        let boat = Boat(
                            id: UUID().uuidString,
                            name: name,
                            type: type,
                            number: number,
                            club: club,
                            image: "",
                            owners: [authService.currentUser!.id],
                            crew: [authService.currentUser!.id],
                            images: []
                        )
                        
                        Task {
                            boatsVM.create(boat, image)
                            
                            dismiss()
                        }
                        
                    }) {
                        Text("Ajouter le bateau")
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .navigationBarTitle("Ajouter un bateau", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Retour")
            }
        )
        
    }
}
