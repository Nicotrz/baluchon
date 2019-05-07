//
//  WeatherService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class WeatherService {

    // MARK: Enum
    enum City: String {
        case brussel = "2800866"
        case nyc = "5128581"
    }

    // MARK: Singleton Property
    static var shared = WeatherService()

    // MARK: Init methods

    // Init private for Singleton
    private init() {}

    // init for testing purposes
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

    // MARK: private properties

    // The URL for the request
    private var requestURL = "https://api.openweathermap.org/data/2.5/weather"

    // The task for the request
    private var task: URLSessionDataTask?

    // The session for the request
    private var weatherSession = URLSession(configuration: .default)

    // The Rate object to collect current rates
    //private var rates: Rate?
    private var request: Weather?

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
        guard let resultKey = dict["weatherKey"] as? String else {
            return ""
        }
        return resultKey
    }

    // MARK: Private methods

    // Creating the request from the URL with accessKey
    private func createWeatherRequest(city: City) -> URLRequest {
        requestURL += "?id=\(city.rawValue)&appid=\(accessKey)&lang=fr&units=metric"
        let weatherUrl = URL(string: requestURL)!
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        return request
    }

    // This function translate the result in a version suitable for the label
    // ( example: It&#39;s become It's )
    private func convertTextIntoAPrettyString(textToConvert: String) -> [Bool: String] {
        var resultToSend = ""
        guard let encodedData = textToConvert.data(using: .utf8) else {
            return [false: ""]
        }

        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(
                data: encodedData, options: attributedOptions, documentAttributes: nil)
            resultToSend = attributedString.string
        } catch {
            return [false: ""]
        }
        return [true: resultToSend]
    }

    // MARK: Public methods

    // Get the translation. We need a closure on argument with:
    // - request success ( yes or no )
    // - String? contain the result in form of a pretty string
    func getWeather(city: City, callback: @escaping (Bool, [String]?) -> Void) {
        let request = createWeatherRequest(city: city)
        task?.cancel()
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let resultConvert = self.convertTextIntoAPrettyString(
                    textToConvert: responseJSON.weather[0].description)
                guard resultConvert != [false: ""] else {
                    callback(false, nil)
                    return
                }
                callback(true, [resultConvert[true]!, String(responseJSON.main.temp)])
            }
        }
        task?.resume()
        WeatherService.shared = WeatherService()
    }
}
