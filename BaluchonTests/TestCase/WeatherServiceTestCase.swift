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

//        var fakeWeatherData = FakeData(typeOfData: "Weather")
//
//        func testGetWeatherShouldPostFailedCallbackIfError() {
//            let weatherService = WeatherService(
//                weatherSession: URLSessionFake(data: nil, response: nil, error: fakeWeatherData.error))
//            let expectaction = XCTestExpectation(description: "Wait for queue change.")
//          //  weatherService.getWeather(city: .nyc) { (success, result) in
//                XCTAssertFalse(success)
//                XCTAssertNil(result)
//                expectaction.fulfill()
//            }
//            wait(for: [expectaction], timeout: 0.01)
//        }
//
//        func testGetWeatherShouldPostFailedCallbackIfNoData() {
//            let weatherService = WeatherService(
//                weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
//            let expectaction = XCTestExpectation(description: "Wait for queue change.")
//     //       weatherService.getWeather(city: .nyc) { (success, result) in
//                XCTAssertFalse(success)
//                XCTAssertNil(result)
//                expectaction.fulfill()
//            }
//            wait(for: [expectaction], timeout: 0.01)
//        }
//
//        func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
//            let weatherService = WeatherService(
//                weatherSession: URLSessionFake(
//                    data: fakeWeatherData.correctData, response: fakeWeatherData.responseKO, error: nil))
//            let expectaction = XCTestExpectation(description: "Wait for queue change.")
//     //       weatherService.getWeather(city: .nyc) { (success, result) in
//                XCTAssertFalse(success)
//                XCTAssertNil(result)
//                expectaction.fulfill()
//            }
//            wait(for: [expectaction], timeout: 0.01)
//        }
//
//    //    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
//       //     let weatherService = WeatherService(
//          //      weatherSession: URLSessionFake(
//          //          data: fakeWeatherData.incorrectData, response: fakeWeatherData.responseOK, error: nil))
//        //    let expectaction = XCTestExpectation(description: "Wait for queue change.")
//      //      weatherService.getWeather(city: .nyc) { (success, result) in
//           //     XCTAssertFalse(success)
//           //     XCTAssertNil(result)
//           //     expectaction.fulfill()
//           // }
//          //  wait(for: [expectaction], timeout: 0.01)
//        }
//
//        func testGetWeatherShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
//            let weatherService = WeatherService(
//                weatherSession: URLSessionFake(
//                    data: fakeWeatherData.correctData, response: fakeWeatherData.responseOK, error: nil))
//            let expectaction = XCTestExpectation(description: "Wait for queue change.")
//        //    weatherService.getWeather(city: .nyc) { (success, result) in//
//                XCTAssert(success)
//                XCTAssertEqual(result, ["couvert", "12.14"])
//                expectaction.fulfill()
//            }
//            wait(for: [expectaction], timeout: 0.01)
//        }
}