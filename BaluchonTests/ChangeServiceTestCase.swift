//
//  ChangeServiceTestCase.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import XCTest
@testable import Baluchon

class ChangeServiceTestCase: XCTestCase {

    func testRefreshChangeShouldPostFailedCallbackIfError() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: FakeChangeData.error))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testRefreshChangeShouldPostFailedCallbackIfNoData() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testRefreshChangeShouldPostFailedCallbackIfIncorrectResponse() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeChangeData.changeCorrectData, response: FakeChangeData.responseKO, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testRefreshChangeShouldPostFailedCallbackIfIncorrectData() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeChangeData.changeIncorrectData, response: FakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
           XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

}
