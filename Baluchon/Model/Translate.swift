//
//  Translate.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 06/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

// Structure of the json sending back from the Google translate API
// For an example, please check the Translation.json file
// On the BaluchonTests folder

struct Translate: Codable {
    var data: DataClass
}

struct DataClass: Codable {
    var translations: [Translation]
}

struct Translation: Codable {
    // The result text is here!
    var translatedText: String
}
