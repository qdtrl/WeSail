//
//  EventsViewTests.swift
//  WeSailUITests
//
//  Created by Quentin Dubut-Touroul on 11/12/2023.
//

import XCTest

final class EventsViewTests: XCTestCase {
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

    func testEventsView() {
        XCTAssertTrue(app.buttons["eventsTab"].waitForExistence(timeout: 2), "Navbar Events view should be displayed")
        
        
    }
}
