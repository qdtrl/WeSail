// //
// //  ChatsModelTests.swift
// //  WeSailTests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

// import XCTest
// @testable import WeSail

// final class ChatsModelTests: XCTestCase {
//     private var chatsModel = ChatsModel()

//     override func setUp() {
//         super.setUp()
//     }
    
//     override func tearDown() {
//         super.tearDown()
//     }

//     func testPostMessage() {
//         let chat = chatsModel.mockData[0]
//         let message = chatsModel.postMessage("Hello", in: chat)
//         XCTAssertEqual(message?.text, nil)
//     }

//     func testGetSectionMessages() {
//         let chat = chatsModel.mockData[0]
//         let sectionMessages = chatsModel.getSectionMessages(for: chat)
//         XCTAssertEqual(sectionMessages.count, 1)
//     }

//     func testGetSearchedRooms() {
//         let searchedRooms = chatsModel.getSearchedRooms(query: "Chat")
//         XCTAssertEqual(searchedRooms.count, 0)
//     }
    
//     func testMarkAsRead() {
//         let chat = chatsModel.mockData[0]
//         chatsModel.markAsRead(true, chat: chat)
//         XCTAssertEqual(chatsModel.mockData[0].messages.last?.isRead, false)
//     }
// }
