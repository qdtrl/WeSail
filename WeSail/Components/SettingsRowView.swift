//
//  SettingsRowView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct SettingsRowView: View {
    var imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}
