//
//  FakeData.swift
//  BaluchonTests
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class FakeData {

    // MARK: - Privat property
    private var typeOfData: String

    // MARK: - INIT
    init(typeOfData: String) {
        self.typeOfData = typeOfData
    }

    // MARK: - Data
    var correctData: Data? {
        let bundle = Bundle(for: FakeData.self)
        let url = bundle.url(forResource: typeOfData, withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    let responseOK = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    let responseKO = HTTPURLResponse(
        url: URL(string: "http://www.gogole.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ChangeError: Error { }
    let error = ChangeError()
}
