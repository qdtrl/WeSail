//
//  LoginView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct LoginView: View {
//    @State var authManager = AuthManager.shared
    @State var email: String = ""
    @State var password: String = ""
    @Binding var isAuthenticated: Bool
    
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
                        
                        InputView(text: $password, 
                                  title: "Mot de passe",
                                  placeHolder: "Entrez votre mot de passe",
                                  isSecureField: true)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isAuthenticated = true
//                                authManager.signInWithEmail(email: email, password: password) { result in
//                                    switch result {
//                                    case .success(let success):
//                                        print(success)
//                                    case .failure(let error):
//                                        print(error.localizedDescription)
//                                    }
//                                }
                        }, label: {
                            Text("Connection")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color((email.isEmpty || password.isEmpty) ? .systemGray : .blue))
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .overlay(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .stroke(.blue, lineWidth: 0)
                                    )
                        })
                        .disabled(email.isEmpty || password.isEmpty)
                        

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
                    
                    Spacer()
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Pas encore de compte ?")
                            .foregroundColor(.gray)
                            .padding()
                            .underline()
                    }.navigationBarHidden(true)
                        
                }.padding()
            
        }
        
    }
}

#Preview {
    LoginView(isAuthenticated: .constant(false))
}

