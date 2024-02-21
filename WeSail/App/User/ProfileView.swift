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
                                Text("\(usersVM.events.count)")
                                    .bold()
                                Text("Events")
                            }
                            Spacer()
                            VStack {
                                Text("123 K")
                                    .bold()
                                Text("Followers")
                            }
                            Spacer()
                            VStack {
                                Text("123 K")
                                    .bold()
                                Text("Abonné(e)s")
                            }
                        }
                        Text("\(user.firstName) \(user.lastName)")
                            .bold()
                        Text("Petite description des familles super longue pour voir ce ")
                        
                        
                        if (user == authService.currentUser!) {
                            HStack {
                                Spacer()
                                
                                Button(action: {}) {
                                    Text("Mon calendrier")
                                    
                                }
                                .frame(width: 120)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(.black)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                
                                Spacer()
                            }
                        } else {
                            HStack {
                                Spacer()
                                
                                Button(action: {}) {
                                    Text("Suivre")
                                    
                                }
                                .frame(width: 120)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(.black)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Text("Écrire")
                                    
                                }
                                .frame(width: 120)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .foregroundColor(.black)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                
                                Spacer()
                            }
                        }
                        
                        
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
                    
                    switch index {
                    case 0:
                        EventsListView(events: usersVM.events)
                    case 1:
                        PicturesView(pictures: usersVM.images)
                    case 2:
                        BoatsListView(boats: usersVM.boats)
                    default:
                        Text("Événements")
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
            usersVM.events(userId: userId)
            usersVM.images(userId: userId)
            usersVM.boats(userId: userId)
        }
    }
}


//#Preview {
//    ProfileView(user: UserViewModel().mockData[0])
//}

