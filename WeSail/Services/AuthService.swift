//
//  AuthViewModel.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthentificationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        print("test")
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(
                id: result.user.uid,
                email: email,
                firstName: firstName,
                lastName: lastName,
                image: "")

            try Firestore.firestore().collection("users").document(user.id).setData(from: user, merge: false)
            await fetchUser()
        } catch {
            print("\(error.localizedDescription)")
        }  
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func resetPassword(withEmail email:String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func updatePassword(password: String) async throws {
        do {
            try await self.userSession?.updatePassword(to: password)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func deleteUser() async throws {
        do {
            try await self.userSession?.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument(as: User.self) else { return }
        
        self.currentUser = snapshot
        
        print("Fetch User")
        print(self.currentUser)
        print(self.userSession)
    }
}
