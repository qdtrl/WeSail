//
//  UpdateProfileView.swift
//  WeSail
//
//  Created by Quentin Touroul on 31/05/2024.
//

import SwiftUI
import UIKit

struct UpdateProfileView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var userVM: UserViewModel
    
    @Environment(\.dismiss) var dismiss

    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var description: String  = ""
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
                                .frame(width: 200, height: 160)
                                .clipped()
                            
                        } else {
                            UserImageView(image: image, width: 200)
                                .onTapGesture {
                                    self.showingImagePicker = true
                                }
                        }
                        Spacer()
                    }

                    TextField("Prénom", text: $firstName)
                    
                    TextField("Nom", text: $lastName)
                    
                    TextField("Description", text: $description)
                    .frame(height: 100)

                }
                
                Button {
                    Task {
                        let user = User(id: authService.currentUser?.id ?? "", email: authService.currentUser?.email ?? "", firstName: firstName, lastName: lastName, description: description, image: image)

                        userVM.update(user: user, image: inputImage ?? UIImage())
                        
                        dismiss()
                    }
                } label: {
                    Text("Mettre à jour")
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .onAppear {
            self.firstName = authService.currentUser?.firstName ?? ""
            self.lastName = authService.currentUser?.lastName ?? ""
            self.description = authService.currentUser?.description ?? ""
            self.image = authService.currentUser?.image ?? ""
        }
    }
}
