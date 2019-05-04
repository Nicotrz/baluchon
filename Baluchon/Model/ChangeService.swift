//
//  ChangeService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class ChangeService {

    static var shared = ChangeService()
    static var rates: Rate?

    private init() {}

    private var accessKey: String {
        guard let path = Bundle.main.path(forResource: "keys", ofType: "plist") else {
            return ""
        }
        let keys = NSDictionary(contentsOfFile: path)
        guard let dict = keys else {
            return ""
        }
        guard let resultKey = dict["changeKey"] as? String else {
            return ""
        }
        return resultKey
        }

    private var task: URLSessionDataTask?

    private var changeSession = URLSession(configuration: .default)

    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }

    private func createChangeRequest() -> URLRequest {
        let changeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(accessKey)")!
        var request = URLRequest(url: changeUrl)
        request.httpMethod = "GET"
        return request
    }

    func refreshChangeRate(callback: @escaping (Bool, Rate?) -> Void) {
        let request = createChangeRequest()
        task?.cancel()
        task = changeSession.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Rate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
         task?.resume()
    }

    func convertCurrency(numberToConvert: Double ) -> Double {
        guard let unwrappedRate = ChangeService.rates else {
            return 0
        }
        guard let reference = unwrappedRate.rates["USD"] else {
            return 0
        }
        let resultToSend = Double(round(100*numberToConvert*reference)/100)
        return ( resultToSend )
    }

}
