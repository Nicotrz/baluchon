//
//  FakeWeatherData.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class FakeWeatherData {
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeWeatherData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    static let weatherIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ChangeError: Error { }
    static let error = ChangeError()
}
