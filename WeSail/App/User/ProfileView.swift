//
//  ProfileView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var usersVM: UserViewModel

    @State var userId: String

    @State var index:Int = 0

    var body: some View {
        ZStack {
            if let user = usersVM.user {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            UserImageView(image: user.image, width: 70)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(boatsVM.boatsUserInCrew.map { $0.events }.count)")
                                    .bold()
                                Text("Events")
                            }
                            Spacer()
                            VStack {
                                Text("\(user.followers?.count ?? 0)")
                                    .bold()
                                Text("Followers")
                            }
                            Spacer()
                            VStack {
                                Text("\(user.subscribers?.count ?? 0)")
                                    .bold()
                                Text("Abonné(e)s")
                            }
                        }

                        Text("\(user.firstName) \(user.lastName)")
                            .bold()

                        Text("\(user.description)")
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
                        EventsListView(events: boatsVM.boatsUserInCrew.map { $0.events }.flatMap { $0 })
                    } else if index == 1 {
                        PicturesListView(pictures: boatsVM.boatsUserInCrew.map { $0.images }.flatMap { $0 })
                    } else {
                        BoatsListView(boats: boatsVM.boatsUserInCrew)
                    }
                }
                .accessibility(identifier: "profileView")
                .toolbar {
                    if (user == authService.currentUser!) {
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
        }
    }
}


//#Preview {
//    ProfileView(user: UserViewModel().mockData[0])
//}

