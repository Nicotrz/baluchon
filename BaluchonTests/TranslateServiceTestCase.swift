//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 06/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//
@testable import Baluchon
import XCTest

class TranslateServiceTestCase: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeTranslationData.error))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
            translateService.getTranslation(textToTranslate: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(textToTranslate: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeTranslationData.translateCorrectData, response: FakeTranslationData.responseKO, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(textToTranslate: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeTranslationData.translateIncorrectData, response: FakeTranslationData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(textToTranslate: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeTranslationData.translateCorrectData, response: FakeTranslationData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(textToTranslate: "Mon tailleur est riche)") { (success, translation) in
            XCTAssert(success)
            XCTAssertEqual(translation, "My tailor is rich")
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

}
