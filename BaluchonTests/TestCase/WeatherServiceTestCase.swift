//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//
    @testable import Baluchon
    import XCTest

    class WeatherServiceTestCase: XCTestCase {

        var fakeWeatherData = FakeData(typeOfData: "Weather")

        override func setUp() {
            WeatherService.shared.resetShared()
            super.setUp()
        }

        func testGetWeatherShouldPostFailedCallbackIfError() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(data: nil, response: nil, error: fakeWeatherData.error))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
                weatherService.getWeather(city: .getOrigin) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldPostFailedCallbackIfNoData() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
                weatherService.getWeather(city: .getDestination) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: fakeWeatherData.correctData, response: fakeWeatherData.responseKO, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .getDestination) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: fakeWeatherData.incorrectData, response: fakeWeatherData.responseOK, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .getDestination) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: fakeWeatherData.correctData, response: fakeWeatherData.responseOK, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .getDestination) { (success, result) in
                XCTAssert(success)
                XCTAssertEqual(result?.main.temp, 12.14)
                XCTAssertEqual(result?.prettyDescriptionString, "couvert")
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testWhenSettingCitiesThenCitiesShouldBeAligned() {
            WeatherService.shared.setDestinationCity(destinationCity: "2800866")
            WeatherService.shared.setOriginCity(originCity: "7303514")
            XCTAssertEqual(WeatherService.shared.getOriginCity(), "7303514")
            XCTAssertEqual(WeatherService.shared.getDestinationCity(), "2800866")
        }
}
