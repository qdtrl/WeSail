//
//  EventsViewModelTests.swift
//  WeSailTests
//
//  Created by Quentin Touroul on 19/06/2024.
//

import XCTest
@testable import WeSail

class EventRepositoryMock: EventRepositoryProtocol {
    func indexBoatEvents(boatId: String) async throws -> [Event] {
        return EventsViewModel().mockData
    }
    
    func indexUserEvents(userId: String) async throws -> [Event] {
        return EventsViewModel().mockData
    }
    
    func create(event: Event) async throws -> Event {
        return EventsViewModel().mockData[0]
    }
    
    func update(event: Event) async throws -> Event {
        return EventsViewModel().mockData[0]
    }
    
    func joinEvent(event: Event, userId: String) async throws -> Event {
        return EventsViewModel().mockData[0]
    }
}

final class EventsViewModelTests: XCTestCase {
    private var eventsVM: EventsViewModel = EventsViewModel()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIndexBoatEvents() {
        let eventRepositoryMock = EventRepositoryMock()
        eventsVM.repository = eventRepositoryMock
        eventsVM.indexBoatEvents(boatId: "boatId")

        XCTAssertEqual(eventsVM.events.count, 0)
    }

    func testIndexUserEvents() {
        let eventRepositoryMock = EventRepositoryMock()
        eventsVM.repository = eventRepositoryMock
        eventsVM.indexUserEvents(userId: "userId")

        XCTAssertEqual(eventsVM.events.count, 0)
    }
    
    func testCreate() {
        let eventRepositoryMock = EventRepositoryMock()
        eventsVM.repository = eventRepositoryMock
     
        eventsVM.create(event: EventsViewModel().mockData[0]) { event in
            XCTAssertEqual(event, EventsViewModel().mockData[0])
        }
    }

    func testUpdate() {
        let eventRepositoryMock = EventRepositoryMock()
        eventsVM.repository = eventRepositoryMock

        eventsVM.update(event: EventsViewModel().mockData[0]) { event in
            XCTAssertEqual(event, EventsViewModel().mockData[0])
        }
    }

    func testJoinEvent() {
        let eventRepositoryMock = EventRepositoryMock()
        eventsVM.repository = eventRepositoryMock

        eventsVM.joinEvent(event: EventsViewModel().mockData[0], userId: "userId") { event in
            XCTAssertEqual(event, EventsViewModel().mockData[0])
        }
    }
}
