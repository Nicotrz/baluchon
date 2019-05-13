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

    // These tests are made to match
    // The date of today.
    // Before launching them, please put the date of today on the ChangeRate.json file

    // Contain the today date
    private var today = Date()

    // Retrieve the date of today and sending in back with yyyy-MM-dd format
    private var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: today)
    }

    var fakeChangeData = FakeData(typeOfData: "ChangeRate")

    override func setUp() {
        ChangeService.shared.resetShared()
        super.setUp()
    }

    func testIsRatesEnabledShouldReturnFalseIfRatesAreNotRefreshed() {
        XCTAssertFalse(ChangeService.shared.ratesEnabled)
    }

    func testRefreshChangeShouldPostFailedCallbackIfError() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: fakeChangeData.error))
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
                data: fakeChangeData.correctData, response: fakeChangeData.responseKO, error: nil))
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
                data: fakeChangeData.incorrectData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
           XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testConvertCurrencyShouldSendBackCorrectAnswerIfRatesAreRefreshed() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .requestSuccessfull)
            XCTAssertEqual(refreshDate, self.todayDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
        XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1"), "1,12 $")
    }

    func testConvertInvalidNumberConvertCurrencyShouldSendBackEmptyString() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .requestSuccessfull)
            XCTAssertEqual(refreshDate, self.todayDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
        XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1,5,5"), "")
    }

    func testConvertWhitoutRefreshRateFirstConvertCurrencyShouldSendBackEmptyString() {
        XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "1"), "")
    }

    func testWhenChangeCurrencyThenCurrencyShouldReflectThatChange() {
        ChangeService.shared.setCurrencies(fromCurrency: "USD")
        ChangeService.shared.setCurrencies(toCurrency: "AFN")
        XCTAssertEqual(ChangeService.shared.getStartingCurrency(), "USD")
        XCTAssertEqual(ChangeService.shared.getDestinationCurrency(), "AFN")
    }

    func testWhenDataIsRefreshedAndWeTryToRefreshAgainThenResponseShouldBeAlreadyRefreshed() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .requestSuccessfull)
            XCTAssertEqual(refreshDate, self.todayDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
        let expectation2 = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .alreadyRefreshed)
            XCTAssertNil(refreshDate)
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 0.01)
    }

    func testWhenRatesAreInvalidWhenTryingToConvert_ResultShouldBeEmpty() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: fakeChangeData.correctData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
            XCTAssertEqual(errorCase, .requestSuccessfull)
            XCTAssertEqual(refreshDate, self.todayDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
        ChangeService.shared.setCurrencies(fromCurrency: "Toto")
        XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "4"), "")
        ChangeService.shared.setCurrencies(fromCurrency: "EUR")
        ChangeService.shared.setCurrencies(toCurrency: "Toto")
        XCTAssertEqual(ChangeService.shared.convertCurrency(numberToConvert: "4"), "")
    }
}
