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

}
