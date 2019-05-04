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

    func testGetChangeShouldPostFailedCallbackIfError() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: FakeChangeData.error))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetChangeShouldPostFailedCallbackIfNoData() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetChangeShouldPostFailedCallbackIfIncorrectResponse() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeChangeData.changeCorrectData, response: FakeChangeData.responseKO, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetChangeShouldPostFailedCallbackIfIncorrectData() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeChangeData.changeIncorrectData, response: FakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetChangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeChangeData.changeCorrectData,
                response: FakeChangeData.responseOK,
                error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (success, change) in
            // Then
            let date = "2019-05-03"
            let USD = 1.119301
            XCTAssertTrue(success)
            XCTAssertNotNil(change)
            XCTAssertEqual(date, change!.date)
            XCTAssertEqual(USD, change!.rates["USD"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}