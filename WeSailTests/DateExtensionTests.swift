// //
// //  DateExtensionTests.swift
// //  WeSailTests
// //
// //  Created by Quentin Dubut-Touroul on 11/12/2023.
// //

import XCTest
@testable import WeSail

final class DateExtensionTests: XCTestCase {
    func testDescriptiveString() {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let minus5Day = Calendar.current.date(byAdding: .day, value: -4, to: today)!
        let more5Day = Calendar.current.date(byAdding: .day, value: -10, to: today)!

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        XCTAssertEqual(today.descriptiveString(), "Aujourd'hui")
        XCTAssertEqual(yesterday.descriptiveString(), "Hier")
        XCTAssertTrue(["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"].contains(minus5Day.descriptiveString()))
        XCTAssertEqual(more5Day.descriptiveString() , formatter.string(from: more5Day))
    }
    
    func testDaysBetween() {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let daysBetween = today.daysBetween(date: tomorrow)
        
        XCTAssertEqual(daysBetween, 1)
    }

    func testDaysBetweenIdenticalDates() {
        let date = Date()
        let daysBetween = date.daysBetween(date: date)
        XCTAssertEqual(daysBetween, 0)
    }
}
