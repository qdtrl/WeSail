//
//  EventsListView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 11/02/2024.
//

import SwiftUI

struct EventsListView: View {
    @EnvironmentObject var eventsVM: EventsViewModel
    @State var boat: Boat
    
    var body: some View {
        Text("Event List")
    }
}

//#Preview {
////    EventsListView()
//}
