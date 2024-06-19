// //
// //  ChatsViewTests.swift
// //  WeSailUITests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

  import XCTest

  final class AuthPageViewTests: XCTestCase {
      private var app: XCUIApplication!

      override func setUp() {
          super.setUp()
          continueAfterFailure = false
          app = XCUIApplication()
          app.launchArguments = ["-isUITesting"]
          app.launch()
      }
    
      override func setUpWithError() throws {
          super.setUp()
          continueAfterFailure = false
          app = XCUIApplication()
          app.launchArguments = ["-isUITesting"]
          app.launch()
      }
    
      override func tearDownWithError() throws {
          app = nil
          super.tearDown()
      }

      override func tearDown() {
          app = nil
          super.tearDown()
      }

      func testLoginView() {
            let logginButton = app.buttons["Connection"]
            XCTAssertTrue(logginButton.waitForExistence(timeout: 2), "Navbar BoatItem view should be displayed")
      }
      
      func testRegisterView() {
          let registerLink = app.buttons["Pas encore de compte ?"]
          XCTAssertTrue(registerLink.waitForExistence(timeout: 2), "Navbar BoatItem view should be displayed")

          registerLink.tap()
      }
  }

