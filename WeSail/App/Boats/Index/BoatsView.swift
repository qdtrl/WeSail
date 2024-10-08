//
//  BoatsView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI
import Firebase

struct BoatsView: View {
    @EnvironmentObject var boatsVM: BoatsViewModel
    @EnvironmentObject var authService: AuthService

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1)

    var body: some View {
        VStack {
            if boatsVM.isLoading {
                Spacer()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .accessibility(identifier: "loading")
                
                Spacer()
                
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(boatsVM.boatsUserInCrew) { boat in
                            NavigationLink(destination: BoatView(id: boat.id)) {
                                BoatRow(boat: boat)
                                    .frame(maxWidth: .infinity, minHeight: 300)
                                    .accessibility(identifier: "boatCell")
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .accessibility(identifier: "boatsGrid")
                    .navigationTitle("Mes Bateaux")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: SearchBoatView()) {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: CreateBoatView()) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
                .foregroundColor(.black)
                .refreshable {
                    boatsVM.index()

                    guard let currentUser = authService.currentUser else {
                        return
                    }
                    boatsVM.indexWhereUserInCrew(userId: currentUser.id)
                }
            }
        }
        .onAppear() {
            guard let currentUser = authService.currentUser else {
                return
            }
            boatsVM.indexWhereUserInCrew(userId: currentUser.id)
            Analytics.logEvent(AnalyticsEventScreenView,
                        parameters: [AnalyticsParameterScreenName: "\(BoatsView.self)",
                                    AnalyticsParameterScreenClass: "\(BoatsView.self)"])
        }
        
    }
}

