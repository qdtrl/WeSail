// //
// //  ChatsModelTests.swift
// //  WeSailTests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

import XCTest
@testable import WeSail

class ConversationRepositoryMock: ConversationRepositoryProtocol {
    func index(userId: String) async throws -> [Conversation] {
        return []
    }

    func show(conversationId: String) async throws -> Conversation {
        return ConversationsViewModel().mockData[0]
    }
    
    func create(conversation: Conversation) async throws -> Conversation {
        return conversation
    }

    func update(conversation: Conversation) async throws {
    }

    func delete(conversation: Conversation) async throws {
    }
}

final class ConversationsViewModelTests: XCTestCase {
    private var conversationsVM: ConversationsViewModel = ConversationsViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testIndex() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock
        conversationsVM.index(userId: "userId")
        
        XCTAssertEqual(conversationsVM.conversations.count, 0)
    }

    func testSearch() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock
        conversationsVM.conversations = ConversationsViewModel().mockData
        conversationsVM.search(query: "Rapetou")
        
        XCTAssertEqual(conversationsVM.conversationsSearch.count, 0)
    }

    func testSearchEmpty() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock
        conversationsVM.search(query: "")
        
        XCTAssertEqual(conversationsVM.conversationsSearch.count, 0)
    }

    func testCreate() {
        let conversationRepositoryMock = ConversationRepositoryMock()

        conversationsVM.repository = conversationRepositoryMock

        conversationsVM.create(ConversationsViewModel().mockData[0])
        
        XCTAssertEqual(conversationsVM.conversationsSearch.count, 0)
    }

    func testShow() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock

        conversationsVM.show(conversationId: "conversationId")
        
        XCTAssertNil(conversationsVM.conversation)
    }

    func testPost() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock
        conversationsVM.conversation = ConversationsViewModel().mockData[1]

        conversationsVM.post(message: ConversationsViewModel().mockData[0].lastMessage)
        
        XCTAssertEqual(conversationsVM.conversation?.lastMessage.id, ConversationsViewModel().mockData[0].lastMessage.id)
    }

    func testPostWithoutConversation() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock

        conversationsVM.post(message: ConversationsViewModel().mockData[0].lastMessage)
        
        XCTAssertEqual(conversationsVM.conversation, nil)
    }

    func testMarkLastMessageAsRead() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock
        conversationsVM.conversation = ConversationsViewModel().mockData[1]

        conversationsVM.markLastMessageAsRead(conversation: ConversationsViewModel().mockData[1])
        
        XCTAssertEqual(conversationsVM.conversation?.lastMessage.isRead, false)
    }

    func testGetSectionMessages() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock

        let oneDayInterval: TimeInterval = 24 * 60 * 60
        let currentDate = Date()
        let oneDayAgo = currentDate.addingTimeInterval(-oneDayInterval)
        let twoDaysAgo = currentDate.addingTimeInterval(-oneDayInterval * 2)

        conversationsVM.messages = [
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: twoDaysAgo, isRead: false),
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: oneDayAgo, isRead: false),
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: currentDate, isRead: false)
        ]

        let sectionMessages = conversationsVM.getSectionMessages()
        
        XCTAssertEqual(sectionMessages.count, 3)
    }


    func testGetSectionMessagesElse() {
        let conversationRepositoryMock = ConversationRepositoryMock()
        conversationsVM.repository = conversationRepositoryMock

        let oneDayInterval: TimeInterval = 24 * 60 * 60
        let currentDate = Date()
        let oneDayAgo = currentDate.addingTimeInterval(-oneDayInterval)
        let twoDaysAgo = currentDate.addingTimeInterval(-oneDayInterval * 2)

        conversationsVM.messages = [
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: currentDate, isRead: false),
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: oneDayAgo, isRead: false),
            Message(id: "1", user: UserViewModel().mockData[0], text: "Hello", date: twoDaysAgo, isRead: false)
        ]

        let sectionMessages = conversationsVM.getSectionMessages()
        
        XCTAssertEqual(sectionMessages.count, 1)
    }
    
}
