// //
// //  ChatsViewTests.swift
// //  WeSailUITests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

// import XCTest

// final class ChatsViewTests: XCTestCase {
//     private var app: XCUIApplication!

//     override func setUp() {
//         super.setUp()
//         continueAfterFailure = false
//         app = XCUIApplication()
//         app.launchArguments = ["-isUITesting"]
//         app.launch()
//     }
    
//     override func setUpWithError() throws {
//         super.setUp()
//         continueAfterFailure = false
//         app = XCUIApplication()
//         app.launchArguments = ["-isUITesting"]
//         app.launch()
//     }
    
//     override func tearDownWithError() throws {
//         app = nil
//         super.tearDown()
//     }

//     override func tearDown() {
//         app = nil
//         super.tearDown()
//     }

//     func testBoatsView() {
//         XCTAssertTrue(app.buttons["chatsTab"].waitForExistence(timeout: 2), "Navbar BoatItem view should be displayed")

//         app.buttons["chatsTab"].tap()
        
//         let chatsList = app.collectionViews["chatsList"]
//         XCTAssertTrue(chatsList.exists, "Chats view should be displayed")

//         XCTAssertEqual(app.cells.count, 3)
        
//         app.cells.firstMatch.swipeRight()
        
//         app.buttons["readLastMessage"].tap()
        
//         app.cells.element(boundBy: 0).tap()
//     }
// }
