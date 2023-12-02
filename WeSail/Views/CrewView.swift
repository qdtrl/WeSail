//
//  CrewView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct CrewView: View {
    let crew: [User]
    var body: some View {
            NavigationView {
                List {
                 ForEach(crew) { user in
                    NavigationLink(destination: ProfileView(user: user)) {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(.gray.opacity(0.2))
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("\(user.firstName) \(user.lastName)")
                                    .bold()
                                Text("Role : Skipper")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
