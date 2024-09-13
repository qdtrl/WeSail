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

final class BoatViewModelTests: XCTestCase {
    private var boatVM: BoatViewModel = BoatViewModel(id: "1")

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }


    func testShow() async {
        let boatRepositoryMock = BoatRepositoryMock()
        boatVM.repository = boatRepositoryMock

        boatVM.show() 

        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }

    func testUploadImage() {
        let boatRepositoryMock = BoatRepositoryMock()

        boatVM.repository = boatRepositoryMock

        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.uploadImageToBoat(UIImage())

        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }

    func testJoinBoat() {
        let boatRepositoryMock = BoatRepositoryMock()
        
        boatVM.repository = boatRepositoryMock
        
        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.joinBoat(user: UserViewModel().mockData[0]) 
        
        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }

    func testUpdateBoat() {
        let boatRepositoryMock = BoatRepositoryMock()
        
        boatVM.repository = boatRepositoryMock
        
        boatVM.boat = BoatsViewModel().mockData[0]

        boatVM.update(boat: BoatsViewModel().mockData[0], image: UIImage())
        
        XCTAssertEqual(BoatsViewModel().mockData[0], BoatsViewModel().mockData[0])
    }
}
