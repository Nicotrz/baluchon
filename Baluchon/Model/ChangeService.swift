//
//  ChangeService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class ChangeService {

    enum ErrorCase {
        case requestSuccessfull
        case alreadyRefreshed
        case networkError
    }

    private var requestURL = "http://data.fixer.io/api/latest?access_key="

    static var shared = ChangeService()

    private var rates: Rate?

    var ratesEnabled: Bool {
        return rates != nil
    }

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

    private var todayDate: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: today)
    }

    private var areDataAlreadyUpdated: Bool {
        return todayDate == rates?.date
    }

    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }

    private func createChangeRequest() -> URLRequest {
        requestURL += "\(accessKey)"
        let changeUrl = URL(string: requestURL)!
        var request = URLRequest(url: changeUrl)
        request.httpMethod = "GET"
        return request
    }

    func refreshChangeRate(callback: @escaping (ErrorCase, String?) -> Void) {
        if areDataAlreadyUpdated {
            callback(.alreadyRefreshed, nil)
        }
        let request = createChangeRequest()
        task?.cancel()
        task = changeSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.networkError, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.networkError, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Rate.self, from: data) else {
                    callback(.networkError, nil)
                    return
                }
                self.rates = responseJSON
                callback(.requestSuccessfull, responseJSON.europeanFormatDate)
            }
        }
            task?.resume()
    }

    func convertCurrency(numberToConvert: String ) -> String {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        let numberFormated = formatter.number(from: numberToConvert)
        guard let toConvert = numberFormated?.doubleValue else {
            return ""
        }
        guard let unwrappedRate = rates else {
            return ""
        }
        guard let reference = unwrappedRate.rates["USD"] else {
            return ""
        }
        let resultToSend = Double(round(100*toConvert*reference)/100)
        return ( String(resultToSend) )
    }
}
