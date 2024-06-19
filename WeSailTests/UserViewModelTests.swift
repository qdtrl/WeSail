//
//  UserViewModelTests.swift
//  WeSailTests
//
//  Created by Quentin Touroul on 19/06/2024.
//

import XCTest
@testable import WeSail

class UserRepoMock: UserRepositoryProtocol {
    func index() async throws -> [User] {
        return UserViewModel().mockData
    }
    
    func show(id: String) async throws -> User {
        return UserViewModel().mockData[0]
    }
    
    func create(user: User, image: UIImage, completion: @escaping (User) -> Void) async throws {
        return completion(user)
    }
    
    func update(user: User, image: UIImage, completion: @escaping (User) -> Void) async throws {
        return completion(user)
    }
    
    func uploadImage(user: User, image: UIImage, completion: @escaping (User) -> Void) async throws {
        return completion(user)
    }
}

final class UserViewModelTests: XCTestCase {
    private var userVM: UserViewModel = UserViewModel()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIndex() {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock

        userVM.index(userId: "userId")

        XCTAssertEqual(userVM.users.count, 0)
    }

    func testSearch() {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock
        userVM.users = UserViewModel().mockData
        userVM.search(query: "Rapetou")

        XCTAssertEqual(userVM.usersSearch.count, 0)
    }

    func testSearchEmpty() {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock
        userVM.users = UserViewModel().mockData
        userVM.search(query: "")

        XCTAssertEqual(userVM.usersSearch.count, 0)
    }

    func testUpdate() {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock

        userVM.update(user: UserViewModel().mockData[0], image: UIImage()) { user in
            XCTAssertEqual(user, UserViewModel().mockData[0])
        }
    }

    func testShow() {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock

        userVM.show(userId: "userId")

        XCTAssertEqual(userVM.user, nil)
    }

    func testGetUserById() async {
        let userRepoMock = UserRepoMock()
        userVM.repository = userRepoMock

        var user:User? = nil
        
        do {
            user = try await userVM.getUserById(userId: "userId")
            XCTAssertEqual(user, UserViewModel().mockData[0])
        } catch {
            XCTFail("Erreur lors de l'exécution de getUserById: \(error)")
        }        

        XCTAssertEqual(user, UserViewModel().mockData[0])
    }
}
