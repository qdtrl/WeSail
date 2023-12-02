////
////  MessageViewTests.swift
////  WeSailUITests
////
////  Created by Quentin Dubut-Touroul on 27/11/2023.
////
//
//import XCTest
//@testable import WeSail
//
//final class MessageViewTests: XCTestCase {
//
//    func testMessageView_WhenFromCurrentUser_ShouldDisplayBlueBackground() throws {
//        // Given
//        let message = Message(userId: "userId", text: "Hello", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let background = try XCTUnwrap(view.background)
//
//        // Then
//        XCTAssertEqual(background, Color.blue)
//    }
//
//    func testMessageView_WhenFromOtherUser_ShouldDisplayGrayBackground() throws {
//        // Given
//        let message = Message(userId: "otherUserUid", text: "Hi", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let background = try XCTUnwrap(view.background)
//
//        // Then
//        XCTAssertEqual(background, Color.gray)
//    }
//
//    func testMessageView_WhenFromCurrentUser_ShouldDisplayWhiteText() throws {
//        // Given
//        let message = Message(userId: "userId", text: "Hello", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let textColor = try XCTUnwrap(view.textColor)
//
//        // Then
//        XCTAssertEqual(textColor, Color.white)
//    }
//
//    func testMessageView_WhenFromOtherUser_ShouldDisplayWhiteText() throws {
//        // Given
//        let message = Message(userId: "otherUserUid", text: "Hi", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let textColor = try XCTUnwrap(view.textColor)
//
//        // Then
//        XCTAssertEqual(textColor, Color.white)
//    }
//
//    func testMessageView_WhenFromCurrentUser_ShouldDisplayCircleImage() throws {
//        // Given
//        let message = Message(userId: "userId", text: "Hello", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let image = try XCTUnwrap(view.image)
//
//        // Then
//        XCTAssertEqual(image.shape, .circle)
//    }
//
//    func testMessageView_WhenFromOtherUser_ShouldDisplayCircleImage() throws {
//        // Given
//        let message = Message(userId: "otherUserUid", text: "Hi", date: Date(), isRead: false, userImage: "person.fill")
//        let view = MessageView(message: message)
//
//        // When
//        let image = try XCTUnwrap(view.image)
//
//        // Then
//        XCTAssertEqual(image.shape, .circle)
//    }
//}
