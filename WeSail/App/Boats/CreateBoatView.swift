//
//  AddBoatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 24/01/2024.
//

import SwiftUI

struct CreateBoatView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @State var name = ""
    @State var type = ""
    @State var number = ""
    @State var club = ""
    @State var image = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
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

                InputView(
                    text: $image,
                    title: "Image",
                    placeHolder: "URL de l'image"
                )
                
                Spacer()
                    
                Button(action: {
                    let boat = Boat(
                        id: UUID().uuidString,
                        name: name,
                        type: type,
                        number: number,
                        club: club,
                        image: "https://www.manche.fr/wp-content/uploads/2023/03/manche-sport-evidence-nautique-cd50-ddaguier-04.jpg",
                        owners: [authService.currentUser!.id],
                        crew: [authService.currentUser!.id]
                    )
                    
                    Task {
                        boatsVM.create(boat)
                    }

                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Ajouter")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.vertical, 20)
                
            }
            .padding(.horizontal, 20)
            
        }
        .navigationBarTitle("Ajouter un bateau", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Retour")
            }
        )
        
    }
}
