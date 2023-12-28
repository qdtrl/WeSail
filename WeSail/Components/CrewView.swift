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
                        AsyncImage(url: URL(string: user.image), transaction: .init(animation: .spring())) { phase in
                            switch phase {
                            case .empty:
                                Color.gray
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
                        .frame(width: 50, height: 50)
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
            .accessibility(identifier: "crewList")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundColor(.black)
    }
}

//#Preview {
//    CrewView(crew: UserModel().mockData)
//}
