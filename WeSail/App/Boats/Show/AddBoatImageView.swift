//
//  AddBoatImageView.swift
//  WeSail
//
//  Created by Quentin Touroul on 17/04/2024.
//

import SwiftUI
import SwiftUI
import FirebaseStorage
import UIKit

struct AddBoatImageView: View {
    @State var boat: Boat
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @EnvironmentObject var boatsVM: BoatsViewModel

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
                        }

                    }
                }
                .padding(40)

            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
