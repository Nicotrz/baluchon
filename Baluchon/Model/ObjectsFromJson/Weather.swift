//
//  Weather.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

// swiftlint:disable variable_name
struct Weather: Codable {

    // This function translate the result in a version suitable for the label
    // ( example: It&#39;s become It's )
    var prettyDescriptionString: String {
        var resultToSend = ""
        guard let encodedData = weather[0].description.data(using: .utf8) else {
            return  ""
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
            return ""
        }
        return resultToSend
    }

    let coord: Coord?
    let weather: [WeatherElement]
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Codable {
    let all: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
    let tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Int?
}

struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}
