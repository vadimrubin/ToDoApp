//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Rubin Vadim on 05.02.2025.
//

import XCTest
@testable import ToDoApp

final class ToDoAppTests: XCTestCase {

    func testSuccesfullGettingDataFromJSON() {
        //arrange
        var tasksCount = 0
        //act
        NetworkManager.shared.getTasks { result in
            switch result {
            case .success(let todos):
                tasksCount = todos.count
                //assert
                XCTAssertEqual(tasksCount, 30)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}
