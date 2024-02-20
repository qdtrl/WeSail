//
//  EventsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct FeedsView: View {
    @EnvironmentObject var feedsVM:FeedsViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(feedsVM.mockData) { event in
                NavigationLink(value: event) {
                    EventRow(event: event)
                        .accessibility(identifier: "eventCell")
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
        }
        .padding(.horizontal)
        .accessibility(identifier: "eventsList")
    }
}


//#Preview {
//    EventsView()
//}
