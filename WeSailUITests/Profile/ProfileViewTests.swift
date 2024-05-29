// //
// //  ProfileViewTests.swift
// //  WeSailUITests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

// import XCTest

// final class ProfileViewTests: XCTestCase {
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
//         XCTAssertTrue(app.buttons["profileTab"].waitForExistence(timeout: 2), "Navbar Profile view should be displayed")

//         app.buttons["profileTab"].tap()
        
//        // Verify that the boats view is displayed
//         let profileView = app.scrollViews["profileView"]
//         XCTAssertTrue(profileView.exists, "Profile view should be displayed")

//         app.buttons["picturesButton"].tap()
//         XCTAssertTrue(app.otherElements["picturesGrid"].exists, "Pictures view should be displayed")
//         app.buttons["eventsButton"].tap()
//         XCTAssertTrue(app.scrollViews["eventsList"].exists, "Events view should be displayed")
//         app.buttons["boatsButton"].tap()
//         XCTAssertTrue(app.otherElements["boatsGrid"].exists, "Crew view should be displayed")
//     }
// }
