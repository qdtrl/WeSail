//
//  InputView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 20/12/2023.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeHolder, text: $text)
                    .font(.system(size: 14))
            }
            
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeHolder: "exemple@wesail.fr", isSecureField: false)
}
