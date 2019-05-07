//
//  FakeTranslationData.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 06/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class FakeTranslationData {
    // MARK: - Data
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeTranslationData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    static let translateIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ChangeError: Error { }
    static let error = ChangeError()
}
