//
//  ChatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var conversationsVM: ConversationsViewModel
    @EnvironmentObject var authService: AuthService

    var conversation: Conversation
    
    @State private var text = ""
    @FocusState private var isFocused
    @State private var messageIdToScroll: UUID?
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ScrollView(showsIndicators: false)  {
                    ScrollViewReader { scrollReader in
                        getMessagesView(viewWidth: reader.size.width)
                            .onAppear {
                                if let messageId = conversation.messages?.last?.id {
//                                    scrollTo(messageId: messageId, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                }
                            }
                    }
                }
            }
            
            HStack (alignment: .top) {
                TextField("Message...", text: $text, axis: .vertical)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .focused($isFocused)
                
                Button(action: {
                    if !text.isEmpty {
                        var message = Message(
                            id: UUID().uuidString,
                            user: authService.currentUser!,
                            text: text,
                            date: Date(),
                            isRead: false)
                        conversationsVM.post(message: message)
                    }
                }) {
                    if conversationsVM.isLoadingMessage {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 37, height: 37)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    } else {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .frame(width: 37, height: 37)
                            .background(text.isEmpty ? Color.gray : Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                .disabled(text.isEmpty)
                     
            }
            .padding()
            .background(.thickMaterial)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
            .onAppear {
                conversationsVM.show(conversationId: conversation.id)
                conversationsVM.markLastMessageAsRead(user: authService.currentUser!, conversation: conversation)
            }
        }
    }
    
    var navBarLeadingBtn: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: conversation.image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(conversation.name)
                    .bold()
            }
            .foregroundColor(.black)
        }
    }
    
    var navBarTrailingBtn: some View {
        Button(action: {}) {
            Image(systemName: "person.2.badge.gearshape")
        }
    }
    
    func scrollTo(messageId: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageId, anchor: anchor)
            }
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]

    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 5, pinnedViews: [.sectionHeaders]) {
            let sectionMessages = conversationsVM.getSectionMessages(for: conversation)
            ForEach(sectionMessages.indices, id: \.self) { sectionIndex in
                let messages = sectionMessages[sectionIndex]
                Section(header: 
                            ZStack {
                                Text(messages.first!.date.descriptiveString(dataStyle: .medium))
                                    .underline()
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                    .background(.black.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                            }
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                ) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
            }
        }
    }
}


//#Preview {

//}
