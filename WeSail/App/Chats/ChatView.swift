//
//  ChatView.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 27/11/2023.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var chatsModel: ChatsModel
    
    var chat: Chat
    
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
                                if let messageId = chat.messages.last?.id {
                                    scrollTo(messageId: messageId, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
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
                        postMessage()
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: 37, height: 37)
                        .background(text.isEmpty ? Color.gray : Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    
                }
                .disabled(text.isEmpty)
                     
            }
            .padding()
            .background(.thickMaterial)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
            .onAppear {
                chatsModel.markAsRead(true, chat: chat)
            }
        }
    }
    
    var navBarLeadingBtn: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: chat.image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(chat.name)
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
    
    func postMessage() {
        if let message = chatsModel.postMessage(text, in: chat) {
            text = ""
            messageIdToScroll = message.id
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]

    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 5, pinnedViews: [.sectionHeaders]) {
            let sectionMessages = chatsModel.getSectionMessages(for: chat)
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
//    ChatView(
//        chat: Chat(
//            chatId: "1", 
//            name: "Planche à voile",
//            image: "figure.sailing",
//            users: [
//                UserModel().mockData[0],
//                UserModel().mockData[1],
//            ],
//            messages: [
//                Message(user: UserModel().mockData[0], text: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[1], text: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[0], text: "How are you ?", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[1],text: "Fine and you ?", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[0], text: "I'm fine too", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[1], text: "Great !", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[0], text: "See you soon", date: Date(), isRead: false),
//                Message(user: UserModel().mockData[1], text: "See youHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello", date: Date(), isRead: false)
//            ]
//        )
//    )
//        .environmentObject(ChatsModel())
//}
