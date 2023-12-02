//
//  Events.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

class EventsModel: ObservableObject {
    @Published var events = [Event]()
    
    @Published var mockData = [
        Event(
            eventId: "1", name: "Les Voiles de Saint-Tropez", organizer: "Société Nautique de Saint-Tropez", description: "Les Voiles de Saint-Tropez is a regatta held annually the last week of September on the Mediterranean around Saint-Tropez, France. It is one of the largest regattas in the world with over 300 modern and classic sailing yachts racing over a week. The regatta is organized by the Société Nautique de Saint-Tropez.", type: "Regatta", images: ["sailboat", "fireworks", "frying.pan"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "2", name: "Les Voiles de Saint-Tropez", organizer: "Société Nautique de Saint-Tropez", description: "Les Voiles de Saint-Tropez is a regatta held annually the last week of September on the Mediterranean around Saint-Tropez, France. It is one of the largest regattas in the world with over 300 modern and classic sailing yachts racing over a week. The regatta is organized by the Société Nautique de Saint-Tropez.", type: "Regatta", images: ["sailboat", "fireworks", "frying.pan"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "3", name: "Les Voiles de Saint-Tropez", organizer: "Société Nautique de Saint-Tropez", description: "Les Voiles de Saint-Tropez is a regatta held annually the last week of September on the Mediterranean around Saint-Tropez, France. It is one of the largest regattas in the world with over 300 modern and classic sailing yachts racing over a week. The regatta is organized by the Société Nautique de Saint-Tropez.", type: "Regatta", images: ["sailboat", "fireworks", "frying.pan"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "4", name: "Les Voiles de Saint-Tropez", organizer: "Société Nautique de Saint-Tropez", description: "Les Voiles de Saint-Tropez is a regatta held annually the last week of September on the Mediterranean around Saint-Tropez, France. It is one of the largest regattas in the world with over 300 modern and classic sailing yachts racing over a week. The regatta is organized by the Société Nautique de Saint-Tropez.", type: "Regatta", images: ["sailboat", "fireworks", "frying.pan"], startDate: Date(), endDate: Date()
        )
    ]
}  
