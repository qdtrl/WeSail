//
//  EventManager.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 30/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class EventManager {
    static let shared = EventManager()
    
    init() {}
    
    let eventCollection = Firestore.firestore().collection("events")
    
    func eventDocument(id: String) -> DocumentReference {
        eventCollection.document(id)
    }
}
