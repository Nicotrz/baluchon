//
//  WeatherService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class WeatherService {

    // MARK: Enumeration

    // This enumeration is to know if
    // We are fetching the weather
    // from the origin or the destination City
    enum City {
        case getOrigin
        case getDestination
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

    // The origin City ID
    private var originCity = "2800866"

    // The destination City ID
    private var destinationCity = "5128581"

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
    // we know witch City to fetch thanks to the city argument
    private func createWeatherRequest(city: City) -> URLRequest {
        var cityID = "0"
        switch city {
        case .getOrigin:
            cityID = originCity
        case .getDestination:
            cityID = destinationCity
        }
        let finalRequest = "\(requestURL)?id=\(cityID)&appid=\(accessKey)&lang=fr&units=metric"
        let weatherUrl = URL(string: finalRequest)!
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        return request
    }

    // MARK: Public methods

    // Reset the Shared object
    func resetShared() {
        WeatherService.shared = WeatherService()
    }

    // Set the origin city
    func setOriginCity(originCity: String) {
        self.originCity = originCity
    }

    // Get the origin city
    func getOriginCity() -> String {
        return originCity
    }

    // Set the destination city
    func setDestinationCity(destinationCity: String) {
        self.destinationCity = destinationCity
    }

    // Get the destination city
    func getDestinationCity() -> String {
        return destinationCity
    }

    // Get the weather. We need a closure on argument with:
    // - request success ( yes or no )
    // - Weather? contain the result in form of a Weather object
    func getWeather(city: City, callback: @escaping (Bool, Weather?) -> Void) {
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
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
