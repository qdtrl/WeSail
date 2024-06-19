//
//  ProfileView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var usersVM: UserViewModel
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var eventsVM: EventsViewModel
    
    @State var userId: String
    @State var currentUser: User?
    @State var index:Int = 0
    @State var events: [Event] = []
    @State var pictures: [String] = []

    var body: some View {
        ZStack {
            if !usersVM.isLoading, usersVM.user != nil {
                NavigationStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                UserImageView(image: usersVM.user!.image, width: 70)
                                
                                Spacer()
                                
                                VStack {
                                    Text("\(events.count)")
                                        .bold()
                                    Text("Events")
                                }
                                Spacer()
                                VStack {
                                    Text("\(boatsVM.boatsUserInCrew.count)")
                                        .bold()
                                    Text("Bateaux")
                                }
                                Spacer()
                                VStack {
                                    Text("\(pictures.count)")
                                        .bold()
                                    Text("Photos")
                                }
                            }

                            Text("\(usersVM.user!.firstName) \(usersVM.user!.lastName)")
                                .bold()

                            Text("\(usersVM.user!.description)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                
                                VStack {
                                    Button(action: {
                                        self.index = 0
                                    }) {
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(index == 0 ? .black : .gray)
                                    }
                                    .accessibility(identifier: "eventsButton")
                                    
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(index == 0 ? .black : .gray)
                                }
                                
                                
                                
                                VStack {
                                    Button(action: {
                                        self.index = 1
                                    }) {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(index == 1 ? .black : .gray)
                                    }
                                    .accessibility(identifier: "picturesButton")
                                    
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(index == 1 ? .black : .gray)
                                }
                                
                                
                                
                                VStack {
                                    Button(action: {
                                        self.index = 2
                                    }) {
                                        Image(systemName: "sailboat")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(index == 2 ? .black : .gray)
                                    }
                                    .accessibility(identifier: "boatsButton")
                                    
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(index == 2 ? .black : .gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)

                        if index == 0 {
                            EventsListView(events: $events)
                        } else if index == 1 {
                            PicturesView(pictures: $pictures)
                        } else {
                            BoatsListView(boats: boatsVM.boatsUserInCrew)
                        }
                    }
                }
                .accessibility(identifier: "profileView")
                .toolbar {
                    if (currentUser == usersVM.user!) {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: ProfileParametersView()) {
                                Image(systemName: "ellipsis")
                            }
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            usersVM.show(userId: userId)
            boatsVM.indexWhereUserInCrew(userId: userId)
            eventsVM.indexUserEvents(userId: userId)

            self.events = eventsVM.events
            self.pictures = boatsVM.boatsUserInCrew.map { $0.images }.flatMap { $0 }
        }
        .onChange(of: boatsVM.boatsUserInCrew) { _ in
            self.pictures = boatsVM.boatsUserInCrew.map { $0.images }.flatMap { $0 }
        }
        .onChange(of: eventsVM.events) { _ in
            self.events = eventsVM.events
        }
        .onChange(of: usersVM.user) { _ in
            if let cU = currentUser, let us = usersVM.user, cU.id == us.id {
                self.currentUser = us
            }
        }
    }
}
