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
    var conversationId: String
    @State private var text = ""
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            if conversationsVM.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 37, height: 37)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            } else {
                GeometryReader { reader in
                    ScrollView(showsIndicators: false)  {
                        ScrollViewReader { scrollReader in
                            getMessagesView(viewWidth: reader.size.width)
                                .onAppear {
                                    guard let lastMessage = conversationsVM.conversation?.lastMessage else {
                                        return
                                    }
                                    scrollTo(messageId: lastMessage.id, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                }
                                .onChange(of: conversationsVM.messages) { _ in
                                    guard let lastMessage = conversationsVM.conversation?.lastMessage else {
                                        return
                                    }
                                    scrollTo(messageId: lastMessage.id, anchor: .bottom, shouldAnimate: true, scrollReader: scrollReader)
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
                        let message = Message(
                            id: UUID().uuidString,
                            user: authService.currentUser!,
                            text: text,
                            date: Date(),
                            isRead: false)
                        conversationsVM.post(message: message)
                        text = ""
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
            .navigationBarItems(leading: navBarLeadingBtn)
            .onAppear {
                conversationsVM.show(conversationId: conversationId)
            }
        }
    }
    
    var navBarLeadingBtn: some View {
        Button(action: {}) {
            HStack {
                if let conversation = conversationsVM.conversation {
                    if conversation.image.isEmpty {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } else {
                        Image(conversation.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    Text(conversation.name)
                        .bold()
                }
            }
            .foregroundColor(.black)
        }
    }
    
    func scrollTo(messageId: String, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageId, anchor: anchor)
            }
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]

    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 5, pinnedViews: [.sectionHeaders]) {
            let sectionMessages = conversationsVM.getSectionMessages()
            ForEach(sectionMessages.indices, id: \.self) { sectionIndex in
                let messages = sectionMessages[sectionIndex]
                if (messages.first != nil) {
                    Section(header:
                                ZStack {
                        Text(((messages.first?.date.descriptiveString(dataStyle: .medium))!))
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
}


//#Preview {

//}
