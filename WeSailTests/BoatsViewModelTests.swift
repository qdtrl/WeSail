//
//  BoatsViewModelTests.swift
//  WeSailTests
//
//  Created by Quentin Touroul on 12/06/2024.
//

import XCTest
@testable import WeSail

class BoatsRepositoryMock: BoatRepositoryProtocol {
    func index() async throws -> [WeSail.Boat] {
        return BoatsViewModel().mockData
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

final class BoatsViewModelTests: XCTestCase {
    private var boatsVM: BoatsViewModel = BoatsViewModel()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIndex() {
        let boatRepositoryMock = BoatsRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.index()

        XCTAssertEqual(boatsVM.boats.count, 0)
    }

    func testIndexWhereUserInCrew() {
        let boatRepositoryMock = BoatsRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.boats = BoatsViewModel().mockData
        boatsVM.indexWhereUserInCrew(userId: "userId")

        XCTAssertEqual(boatsVM.boatsUserInCrew.count, 0)
    }

    func testSearch() {
        let boatRepositoryMock = BoatsRepositoryMock()
        boatsVM.repository = boatRepositoryMock
        boatsVM.boats = BoatsViewModel().mockData
        boatsVM.search(query: "Rapetou")

        XCTAssertEqual(boatsVM.boatsSearched.count, 0)
    }

    func testCreate() {
        let boatRepositoryMock = BoatsRepositoryMock()

        boatsVM.repository = boatRepositoryMock

        boatsVM.create(BoatsViewModel().mockData[0], UIImage())

        XCTAssertEqual(boatsVM.boatsUserInCrew.count, 0)
    }
}
