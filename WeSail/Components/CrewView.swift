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
        VStack(alignment: .leading) {
            ForEach(crew) { user in
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        UserImageView(image: user.image, width: 50)
                                                                     
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
            .accessibility(identifier: "crewList")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundColor(.black)
    }
}

//#Preview {
//    CrewView(crew: UserViewModel().mockData)
//}
