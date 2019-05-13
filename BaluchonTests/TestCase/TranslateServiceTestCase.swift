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

    var fakeTranslationData = FakeData(typeOfData: "Translation")

    override func setUp() {
        TranslateService.shared.resetShared()
        super.setUp()
    }

    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: fakeTranslationData.error))
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
                data: fakeTranslationData.correctData, response: fakeTranslationData.responseKO, error: nil))
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
                data: fakeTranslationData.incorrectData, response: fakeTranslationData.responseOK, error: nil))
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
                data: fakeTranslationData.correctData, response: fakeTranslationData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(textToTranslate: "Mon tailleur est riche)") { (success, translation) in
            XCTAssert(success)
            XCTAssertEqual(translation, "My tailor is rich")
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testWhenSettingLanguagesThenLanguagesShouldBeSet() {
        TranslateService.shared.setOriginLanguage(fromLanguage: "de")
        TranslateService.shared.setDestinationLanguage(toLanguage: "fr")
        XCTAssertEqual(TranslateService.shared.getOriginLanguage(), "de")
        XCTAssertEqual(TranslateService.shared.getDestinationLanguage(), "fr")
    }

}
