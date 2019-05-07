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

        func testGetWeatherShouldPostFailedCallbackIfError() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(data: nil, response: nil, error: FakeWeatherData.error))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .nyc) { (success, result) in
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
            weatherService.getWeather(city: .nyc) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseKO, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .nyc) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: FakeWeatherData.weatherIncorrectData, response: FakeWeatherData.responseOK, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .nyc) { (success, result) in
                XCTAssertFalse(success)
                XCTAssertNil(result)
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }

        func testGetWeatherShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
            let weatherService = WeatherService(
                weatherSession: URLSessionFake(
                    data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil))
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            weatherService.getWeather(city: .nyc) { (success, result) in
                XCTAssert(success)
                XCTAssertEqual(result, ["couvert", "12.14"])
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 0.01)
        }
}
