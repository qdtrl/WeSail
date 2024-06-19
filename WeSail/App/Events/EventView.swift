//
//  EventView.swift
//  WeSail
//
//  Created by Quentin Touroul on 05/06/2024.
//

import SwiftUI


struct EventView: View {
    @EnvironmentObject var eventsVM: EventsViewModel
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    @State var event: Event
    @State var users: [User] = []

    var body: some View {
         VStack {
            HStack {
                Text(event.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .accessibility(identifier: "eventName")

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Du \(event.startDate.formatted(.dateTime.day().month().year()))")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .accessibility(identifier: "eventStartDate")
                    Text("au \(event.endDate.formatted(.dateTime.day().month().year()))")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .accessibility(identifier: "eventEndDate")
                }
            }

            if (event.startDate < Date.now) {
                Text("Commencé")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .accessibility(identifier: "eventFinished")
            } else if (event.endDate < Date.now) {
                Text("Terminé")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .accessibility(identifier: "eventFinished")
            } else {
                if let curUs = authService.currentUser {
                    if (event.participants.firstIndex(where: { $0 ==  curUs.id}) != nil) {
                        Text("Inscrit")
                            .font(.subheadline)
                            .foregroundColor(.green)
                            .accessibility(identifier: "eventRegistered")
                    } else {
                        Button("S'inscrire") {
                            Task {
                                eventsVM.joinEvent(event: event, userId: authService.currentUser!.id) { event in
                                    self.event = event
                                }
                            }
                        }
                    }
                }
            }

            if users.count > 0 {
                ForEach(users, id: \.id) { user in
                    HStack(alignment: .center) {
                        UserImageView(image: user.image, width: 50)
                            .accessibility(identifier: "eventUserImage")
                        
                        Text("\(user.firstName) \(user.lastName)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .accessibility(identifier: "eventUser")
                        
                        Spacer()
                    }
                }     
            } else {
                Text("Aucun participant")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .accessibility(identifier: "noEventUser")
            }   

            Divider() 
        }
        .padding(.horizontal)
        .padding(.bottom)
        .onAppear {
            Task {
                if self.event.participants.count > 0 {
                    boatsVM.getCrew(crew: self.event.participants) { crew in
                        self.users = crew
                    }
                }
            }
        }.onChange(of: event) { _ in
            Task {
                if self.event.participants.count > 0 {
                    boatsVM.getCrew(crew: self.event.participants) { crew in
                        self.users = crew
                    }
                }
            }
        }
            
    }
}
