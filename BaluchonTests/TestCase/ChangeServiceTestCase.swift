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

//    var fakeChangeData = FakeData(typeOfData: "ChangeRate")
//
//    override func setUp() {
//        ChangeService.shared.setUpShared()
//        super.setUp()
//    }
//
//    func testIsRatesEnabledShouldReturnFalseIfRatesAreNotRefreshed() {
//        XCTAssertFalse(ChangeService.shared.ratesEnabled)
//    }
//
//    func testRefreshChangeShouldPostFailedCallbackIfError() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(data: nil, response: nil, error: fakeChangeData.error))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .networkError)
//            XCTAssertNil(refreshDate)
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//    }
//
//    func testRefreshChangeShouldPostFailedCallbackIfNoData() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(data: nil, response: nil, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .networkError)
//            XCTAssertNil(refreshDate)
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//    }
//
//    func testRefreshChangeShouldPostFailedCallbackIfIncorrectResponse() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(
//                data: fakeChangeData.correctData, response: fakeChangeData.responseKO, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .networkError)
//            XCTAssertNil(refreshDate)
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//    }
//
//    func testRefreshChangeShouldPostFailedCallbackIfIncorrectData() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(
//                data: fakeChangeData.incorrectData, response: fakeChangeData.responseOK, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//           XCTAssertEqual(errorCase, .networkError)
//            XCTAssertNil(refreshDate)
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//    }
//
//    func testConvertCurrencyShouldSendBackCorrectAnswerIfRatesAreRefreshed() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(
//                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .requestSuccessfull)
//            XCTAssertEqual(refreshDate, "06/05/2019")
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//     //   XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1", currency: "USD"), "$1.12")
//    }
//
//    func testConvertInvalidNumberConvertCurrencyShouldSendBackEmptyString() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(
//                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .requestSuccessfull)
//            XCTAssertEqual(refreshDate, "06/05/2019")
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//  //      XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1,5,5", currency: "USD"), "")
//    }
//
//    func testConvertWhitoutRefreshRateFirstConvertCurrencyShouldSendBackEmptyString() {
//  //      XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1", currency: "USD"), "")
//    }
//
//    func testConvertWithSendingInvalidCurrencyShouldSendBackEmptyString() {
//        let changeService = ChangeService(
//            changeSession: URLSessionFake(
//                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
//        let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        changeService.refreshChangeRate { (errorCase, refreshDate) in
//            XCTAssertEqual(errorCase, .requestSuccessfull)
//            XCTAssertEqual(refreshDate, "06/05/2019")
//            expectaction.fulfill()
//        }
//        wait(for: [expectaction], timeout: 0.01)
//   //     XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1", currency: "TOTO"), "")
//    }
}
