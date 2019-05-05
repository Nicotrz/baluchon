//
//  ChangeService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class ChangeService {

    // MARK: Singleton Property
    static var shared = ChangeService()

    // MARK: Init methods

    // Init private for Singleton
    private init() {}

    // init for testing purposes
    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }

    // MARK: Enumeration

    // Differents return of ErrorCase possibles
    enum ErrorCase {
        case requestSuccessfull
        case alreadyRefreshed
        case networkError
    }

    // MARK: private properties

    // The URL for the request
    private var requestURL = "http://data.fixer.io/api/latest?access_key="

    // The task for the request
    private var task: URLSessionDataTask?

    // The session for the request
    private var changeSession = URLSession(configuration: .default)

    // The Rate object to collect current rates
    private var rates: Rate?

    // Retrieve the accessKey from the keys.plist file
    // Please note: the software cannot work without it
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

    // Retrieve the date of today and sending in back with yyyy-MM-dd format
    private var todayDate: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: today)
    }

    // Checking if the last update Date match today date
    private var areDataAlreadyUpdated: Bool {
        return todayDate == rates?.date
    }

    // MARK: Public properties

    // Are the rates enabled to use ?
    var ratesEnabled: Bool {
        return rates != nil
    }

    // MARK: Private methods

    // Creating the request from the URL with accessKey
    private func createChangeRequest() -> URLRequest {
        requestURL += "\(accessKey)"
        let changeUrl = URL(string: requestURL)!
        var request = URLRequest(url: changeUrl)
        request.httpMethod = "GET"
        return request
    }

    // Converting a Double number to a pretty number with the USD format
    private func convertToClearNumber(toConvert number: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "en_US")
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        return currencyFormatter.string(from: NSNumber(value: number))!
    }

    // MARK: Public methods

    // Refresh the ChangeRate. We need a closure on argument with:
    // - Type of error for result purpose
    // - String? contain the update date on european format
    // This method send the result to the rates variable
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

    // This method takes the numberToConvert
    // And convert it to USD following the current rates
    // It send the result back with a nice format
    // Thanks to the convertToClearNumber private method
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
        return convertToClearNumber(toConvert: resultToSend)
    }

}
