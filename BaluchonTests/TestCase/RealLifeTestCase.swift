//
//  RealLifeTestCase.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 12/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

@testable import Baluchon

// This class is for testing the calls
// of the networks call in real life situation
// Don't try this at home :-)

import XCTest

class RealLifeTestCase: XCTestCase {

    func testCallAllTranslateFromTranslateService() {
        for language in language {
            let expectaction = XCTestExpectation(description: "Wait for queue change." )
            print("=======")
            print("Testing \(language.descr)")
            print("=======")
            TranslateService.shared.originLanguage = language.code
            TranslateService.shared.getTranslation(textToTranslate: "Tailleur") { (success, translation) in
                XCTAssert(success)
                XCTAssertNotNil(translation)
                print("Success")
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 2.0)
       }
    }

    func testCallAllWeatherFromWeatherService() {
        for city in city {
            let expectaction = XCTestExpectation(description: "Wait for queue change." )
            print("=======")
            print("Testing \(city.city)")
            print("=======")
            WeatherService.shared.originCity = city.cityID
            WeatherService.shared.getWeather(city: .getOrigin) { (success, weather) in
                XCTAssert(success)
                XCTAssertNotNil(weather)
                print("Success")
                expectaction.fulfill()
            }
            wait(for: [expectaction], timeout: 2.0)
            sleep(3)
        }
    }
}
