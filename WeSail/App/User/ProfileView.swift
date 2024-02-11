//
//  ProfileView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authService: AuthService
    @State var index:Int = 0

    var body: some View {
        if let user = authService.currentUser {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        AsyncImage(url: URL(string: user.image!), transaction: .init(animation: .spring())) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .foregroundColor(.gray)
                                    .opacity(0.2)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .scaledToFill()
                            case .failure(_):
                                Color.red.opacity(0.2)
                            @unknown default:
                                Color.yellow.opacity(0.2)
                            }
                        }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        
                        Spacer()
                        
                        VStack {
                            Text("123")
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
                    EventsView()
                case 1:
                    PicturesView()
                case 2:
                    BoatsView()
                default:
                    Text("Événements")
                }
            }
            .accessibility(identifier: "profileView")
        }
    }
}


//#Preview {
//    ProfileView(user: UserViewModel().mockData[0])
//}

