//
//  CrewView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import SwiftUI

struct CrewView: View {
    @Binding var crew: [User]

    var body: some View {
        if crew.isEmpty {
            VStack {
                Spacer()
                Text("Aucun membre d'équipage")
                    .font(.title)
                    .foregroundColor(.gray)
                Spacer()
            }
        } else {
            VStack(alignment: .leading) {
                ForEach(crew) { user in
                    NavigationLink(destination: ProfileView(userId: user.id)) {
                        HStack {
                            UserImageView(image: user.image, width: 50)
                                                                        
                            VStack(alignment: .leading) {
                                Text("\(user.firstName) \(user.lastName)")
                                    .bold()
                                Text("\(user.description)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .accessibility(identifier: "crewList")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundColor(.black)
        }
    }
}
