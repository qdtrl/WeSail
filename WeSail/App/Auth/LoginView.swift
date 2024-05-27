//
//  LoginView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    
    @State var email: String = ""
    @State var noEmailForReset = false
    @State var password: String = ""
    
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
                    
                    HStack {
                        Spacer ()
                        
                        Button {
                            Task {
                                if !email.isEmpty {
                                    try await authService.resetPassword(withEmail: email)
                                } else {
                                    noEmailForReset.toggle()
                                }
                            }
                        } label: {
                            Text("Mot de passe oublié ?")
                        }
                        .alert(isPresented: $noEmailForReset) {
                            Alert(title: Text("Erreur"), message: Text("Veuillez entrer une adresse email valide"), dismissButton: .default(Text("OK")))
                        }
                    }
                    
                }
                
                Spacer()
                
                Button {
                    Task {
                        try await authService.signIn(withEmail: email, password: password)
                    }
                } label: {
                    Text("Connection")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .overlay(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .stroke(.blue, lineWidth: 0)
                            )
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
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

extension LoginView: AuthentificationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

#Preview {
    LoginView()
}

