//
//  Rate.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

// Structure for the result of the changeRate json file
// For an example, please check the ChangeRate.json
// Example file available on BaluchonTests folder

struct Rate: Decodable {

    // Date of the update
    var date: String

    // Same date but on european format
    var europeanFormatDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/YYYY"
        let showDate = inputFormatter.date(from: self.date)
        return outputFormatter.string(from: showDate!)
    }

    // Dictionnary with [Currency: rate]
    let rates: [String: Double]
}
