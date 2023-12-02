//
//  LoginView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct LoginView: View {
//    @State var authManager = AuthManager.shared
    @State var userAlreadyExist: Bool = true
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
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
                        TextField("Email", text: $email)
                            .frame(width: 300)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                        TextField("Mot de passe", text: $password)
                            .frame(width: 300)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                        if !userAlreadyExist {
                            TextField("Confirmation mot de passe", text: $confirmPassword)
                                .frame(width: 300)
                                .padding()
                                .background(.gray.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            if userAlreadyExist {
//                                authManager.signInWithEmail(email: email, password: password) { result in
//                                    switch result {
//                                    case .success(let success):
//                                        print(success)
//                                    case .failure(let error):
//                                        print(error.localizedDescription)
//                                    }
//                                }
                            } else {
//                                authManager.createUserWithEmail(email: email, password: password) { result in
//                                    switch result {
//                                    case .success(let success):
//                                        print(success)
//                                    case .failure(let error):
//                                        print(error.localizedDescription)
//                                    }
//                                }
                            }
                        }, label: {
                            Text(userAlreadyExist ? "Connection" : "Inscription")
                                .foregroundColor(userAlreadyExist ? .white : .blue )
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(userAlreadyExist ? .blue : .white)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .overlay(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .stroke(.blue, lineWidth: userAlreadyExist ? 0 : 2)
                                    )
                        })
                        .disabled(email.isEmpty || password.isEmpty || (!userAlreadyExist && (confirmPassword.isEmpty || password != confirmPassword)))
                        
                        Button(action: {
//                            authManager.signInWithGoogle { result in
//                                switch result {
//                                case .success(let success):
//                                    print(success)
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                }
//                            }
                        }, label: {
                            Text("Google")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        })
                        
                        HStack {
                            Button(action: {
                                userAlreadyExist.toggle()
                            }, label: {
                                Text(userAlreadyExist ? "Pas encore de compte ?" : "Déjà un compte ?")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .underline()
                            })
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .padding()
        }
    }
}
