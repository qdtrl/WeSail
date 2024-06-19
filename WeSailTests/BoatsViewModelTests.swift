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
        return []
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

final class BoatsViewModelTests: XCTestCase {
    private var boatsVM: BoatsViewModel = BoatsViewModel()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIndex() {
        let boatRepositoryMock = BoatRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.index()

        XCTAssertEqual(boatsVM.boats.count, 0)
    }

    func testIndexWhereUserInCrew() {
        let boatRepositoryMock = BoatRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.boats = BoatsViewModel().mockData
        boatsVM.indexWhereUserInCrew(userId: "userId")

        XCTAssertEqual(boatsVM.boatsUserInCrew.count, 0)
    }

    func testShow() async {
        let boatRepositoryMock = BoatRepositoryMock()
        boatsVM.repository = boatRepositoryMock

        var boatShowed:Boat? = nil
        await boatsVM.show(id: "id") { boat in
            boatShowed = boat
        }

        XCTAssertEqual(boatShowed, BoatsViewModel().mockData[0])
    }

    func testGetCrew() async {
        let boatRepositoryMock = BoatRepositoryMock()
        boatsVM.repository = boatRepositoryMock

        var crew:[User] = []
        await boatsVM.getCrew(crew: ["userId"]) { users in
            crew = users
        }

        XCTAssertEqual(crew.count, 0)
    }

    func testSearch() {
        let boatRepositoryMock = BoatRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.boats = BoatsViewModel().mockData
        boatsVM.search(query: "Rapetou")

        XCTAssertEqual(boatsVM.boatsSearched.count, 0)
    }

    func testCreate() {
        let boatRepositoryMock = BoatRepositoryMock()

        boatsVM.repository = boatRepositoryMock

        boatsVM.create(BoatsViewModel().mockData[0], UIImage())

        XCTAssertEqual(boatsVM.boatsUserInCrew.count, 0)
    }

    func testUploadImage() {
        let boatRepositoryMock = BoatRepositoryMock()

        boatsVM.repository = boatRepositoryMock

        var boatUpdated:Boat? = nil
        boatsVM.uploadImageToBoat(BoatsViewModel().mockData[0], UIImage()) { boat in
            boatUpdated = boat
        }

        XCTAssertEqual(boatUpdated, nil)
    }

    func testJoinBoat() {
        let boatRepositoryMock = BoatRepositoryMock()
        
        boatsVM.repository = boatRepositoryMock
        
        var boatUpdated:Boat? = nil
        boatsVM.joinBoat(BoatsViewModel().mockData[0], UserViewModel().mockData[0]) { boat in
            boatUpdated = boat
        }
        
        XCTAssertEqual(boatUpdated, nil)
    }

    func testUpdateBoat() {
        let boatRepositoryMock = BoatRepositoryMock()
        
        boatsVM.repository = boatRepositoryMock
        
        var boatUpdated:Boat? = nil
        boatsVM.update(boat: BoatsViewModel().mockData[0], image: UIImage()) { boat in
            boatUpdated = boat
        }
        
        XCTAssertEqual(boatUpdated, nil)
    }
}
