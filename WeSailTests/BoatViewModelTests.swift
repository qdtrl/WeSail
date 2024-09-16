//
//  BoatsViewModelTests.swift
//  WeSailTests
//
//  Created by Quentin Touroul on 12/06/2024.
//

import XCTest
@testable import WeSail

class BoatRepositoryMock: BoatRepositoryProtocol {
    func index() async throws -> [WeSail.Boat] {
        return []
    }
    
    func show(id: String) async throws -> WeSail.Boat {
        return BoatsViewModel().mockData[0]
    }
    
    func getCrew(crew: [String]) async throws -> [WeSail.User] {
        return UserViewModel().mockData
    }
    
    func create(boat: WeSail.Boat, image: UIImage, completion: @escaping (WeSail.Boat) -> Void) async throws {
        return completion(boat)
    }
    
    func joinBoat(boat: WeSail.Boat, user: WeSail.User, completion: @escaping (WeSail.Boat) -> Void) async throws {
        return completion(boat)
    }
    
    func uploadImage(boat: WeSail.Boat, image: UIImage, completion: @escaping (WeSail.Boat) -> Void) async throws {
        return completion(boat)
    }
    
    func update(boat: WeSail.Boat, image: UIImage, completion: @escaping (WeSail.Boat) -> Void) async throws {
        return completion(boat)
    }
}

final class BoatViewModelTests: XCTestCase {
    private var boatVM: BoatViewModel = BoatViewModel(id: "1")

    override func setUp() {
        super.setUp()
        boatVM = BoatViewModel(id: "1")
        boatVM.repository = BoatRepositoryMock()
        boatVM.eventRepository = EventRepositoryMock()
    }

    override func tearDown() {
        super.tearDown()
    }


    func testShow() async throws {
        // Arrange
        let expectedBoat = BoatsViewModel().mockData[0]
        let expectedCrew = UserViewModel().mockData
        let expectedEvents: [Event] = EventsViewModel().mockData

        // Act
        await MainActor.run {
            boatVM.show()
        }
        
        for _ in 0..<10 { // Essaie jusqu'à 10 fois
            if !boatVM.isLoading {
                break
            }
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconde
        }

        // Assert
        await MainActor.run {
            XCTAssertFalse(boatVM.isLoading, "isLoading should be false after show() completes")
            XCTAssertEqual(boatVM.boat, expectedBoat, "Boat should match the expected boat")
            XCTAssertEqual(boatVM.crew, expectedCrew, "Crew should match the expected crew")
            XCTAssertEqual(boatVM.events.count, expectedEvents.count, "Events should match the expected events")
        }
    }

    func testUploadImage() {
        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.uploadImageToBoat(UIImage())

        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }

    func testJoinBoat() {                
        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.joinBoat(user: UserViewModel().mockData[0]) 
        
        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }

    func testUpdateBoat() {                
        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.update(boat: BoatsViewModel().mockData[0], image: UIImage())
        
        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }
}
