//
//  RegisterView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authService: AuthService

    @Environment(\.dismiss) var dismiss

    @State var email: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @State private var error:String = ""

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
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
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
                        
                        ZStack(alignment: .trailing) {
                            InputView(text: $passwordConfirmation,
                                      title: "Confirmation mot de passe",
                                      placeHolder: "Entrez votre mot de passe",
                                      isSecureField: true)
                            
                            if !password.isEmpty && !passwordConfirmation.isEmpty {
                                if password == passwordConfirmation {
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGreen))
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemRed))
                                }
                            }
                        }
                    }
                
                    Spacer()
                    
                    Button {
                        Task {
                            do {
                                try await authService.createUser(withEmail: email, password: password, firstName: firstName, lastName: lastName)
                            } catch {
                                self.error = error.localizedDescription
                            }
                        }
                    } label: {
                        Text("Inscription")
                            .foregroundColor(.blue )
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .stroke(.blue, lineWidth:  2))
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .alert(isPresented: .constant(!error.isEmpty)) {
                        Alert(title: Text("Erreur"), message: Text(error), dismissButton: .default(Text("OK")) {
                            self.error = ""
                        })
                    }
                    
                
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

extension RegisterView: AuthentificationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@") 
        && !password.isEmpty
        && password.count > 5
        && password == passwordConfirmation
        && !firstName.isEmpty
        && !lastName.isEmpty
        
    }
}

#Preview {
    RegisterView()
}
