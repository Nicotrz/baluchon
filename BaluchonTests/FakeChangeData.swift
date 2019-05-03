//
//  FakeChangeData.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class FakeChangeData {
    // MARK: - Data
    static var changeCorrectData: Data? {
        let bundle = Bundle(for: FakeChangeData.self)
        let url = bundle.url(forResource: "ChangeRate", withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    static let changeIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ChangeError: Error { }
    static let error = ChangeError()
}
