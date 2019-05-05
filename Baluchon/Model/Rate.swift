//
//  Rate.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

struct Rate: Decodable {

    let date: String

    var europeanFormatDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/YYYY"
        let showDate = inputFormatter.date(from: self.date)
        return outputFormatter.string(from: showDate!)
    }

    let rates: [String: Double]
}
