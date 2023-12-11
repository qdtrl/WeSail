//
//  BoatsViewTests.swift
//  WeSailUITests
//
//  Created by Quentin Dubut-Touroul on 11/12/2023.
//

import XCTest

final class BoatsViewTests: XCTestCase {
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

    func testBoatsView() {
        XCTAssertTrue(app.buttons["boatsTab"].waitForExistence(timeout: 2), "Navbar BoatItem view should be displayed")

        app.buttons["boatsTab"].tap()
        
        // Verify that the boats view is displayed
        let boatsGrid = app.otherElements["boatsGrid"]
        XCTAssertTrue(boatsGrid.exists, "Boats view should be displayed")

        let boatsCell = boatsGrid.buttons.containing(NSPredicate(format: "identifier CONTAINS 'boatCell'"))
        XCTAssertEqual(boatsCell.count, 5)
        
        boatsCell.element(boundBy: 0).tap()
        
        let boatView = app.scrollViews["boatView"]
        XCTAssertTrue(boatView.exists, "Boat view should be displayed")

        app.buttons["picturesButton"].tap()
        XCTAssertTrue(app.otherElements["picturesGrid"].exists, "Pictures view should be displayed")
        app.buttons["eventsButton"].tap()
        XCTAssertTrue(app.scrollViews["eventsList"].exists, "Events view should be displayed")
        app.buttons["crewButton"].tap()
        XCTAssertTrue(app.buttons["crewList"].exists, "Crew view should be displayed")
    }
}
