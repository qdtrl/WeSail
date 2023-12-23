//
//  RegisterView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("WeSail")
                                .font(Font.custom("Baskerville-Bold", size: 50))
                                .foregroundColor(.blue)
                            
                            Text("Bienvenue")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Image("LogoText")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150)
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Spacer()
                    
                    VStack {
                        InputView(text: $email,
                                  title: "Address Email",
                                  placeHolder: "nomprenom@wesail.fr")
                        .autocapitalization(.none)
                        
                        InputView(text: $firstName,
                                  title: "Prénom",
                                  placeHolder: "Camille")
                        
                        InputView(text: $lastName, title: "Nom", placeHolder: "OuiSail")
                        
                        InputView(text: $password,
                                  title: "Mot de passe",
                                  placeHolder: "Entrez votre mot de passe",
                                  isSecureField: true)
                        
                        InputView(text: $passwordConfirmation,
                                  title: "Confirmatin mot de passe",
                                  placeHolder: "Entrez votre mot de passe",
                                  isSecureField: true)
                        
                    }
                
                    Spacer()
                    
                    Button(action: {
//                                authManager.createUserWithEmail(email: email, password: password) { result in
//                                    switch result {
//                                    case .success(let success):
//                                        print(success)
//                                    case .failure(let error):
//                                        print(error.localizedDescription)
//                                    }
//                                }
                    }, label: {
                        Text("Inscription")
                            .foregroundColor(.blue )
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .overlay(
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .stroke(.blue, lineWidth:  2)
                                )
                    })
                    .disabled(email.isEmpty || password.isEmpty   || passwordConfirmation.isEmpty || password != passwordConfirmation)
                    
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Déjà un compte ?")
                        .foregroundColor(.gray)
                        .padding()
                        .underline()
                })
            }.padding()
        }.navigationBarHidden(true)
    }
}

#Preview {
    RegisterView()
}
