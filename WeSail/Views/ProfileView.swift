//
//  ProfileView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
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
            Text("Quentin Touroul")
                .bold()
            Text("Petite description des familles super longue pour voir ce ")
            
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Suivre")
                        
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                Spacer()
                
                Button(action: {}) {
                    Text("Écrire")
                        
                }
                .frame(width: 100)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                Spacer()
            }
            
            
            
        }.padding()
    }
}


#Preview {
    ProfileView()
}

