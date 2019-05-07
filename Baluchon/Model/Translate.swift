//
//  Translate.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 06/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

struct Translate: Codable {
    var data: DataClass
}

struct DataClass: Codable {
    var translations: [Translation]
}

struct Translation: Codable {
    var translatedText: String
}
