//
//  UserManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 30/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class UserManager {
    static let shared = UserManager()
    
    init() {}
    
    let userCollection = Firestore.firestore().collection("users")
    
    func userDocument(id: String) -> DocumentReference {
        userCollection.document(id)
    }
}
