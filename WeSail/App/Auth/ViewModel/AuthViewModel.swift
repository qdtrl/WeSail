//
//  AuthViewModel.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(userId: result.user.uid, email: email, firstName: firstName, lastName: lastName, image: "")
            let encodedUser = try Firestore.Encoder().encode(user) 
            try await Firestore.firestore().collection("users").document(user.userId).setData(encodedUser)
        } catch {
            print("\(error.localizedDescription)")
        }  
    }
    
    func signOut() {
        
    }
    
    func deleteUser() {
        
    }
    
    func getUser() async {
        
    }
}
