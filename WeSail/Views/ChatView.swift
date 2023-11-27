//
//  ChatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var  messsages = [Message]()
    
    
}

struct ChatView: View {
    @StateObject var  chatViewModel = ChatViewModel()
    
    
    var body: some View {
        ForEach(chatViewModel.messsages) { message in
            MessageView(message: message)
        }
    }
}

#Preview {
    ChatView()
}
