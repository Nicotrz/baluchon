//
//  TranslateService.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 06/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import Foundation

class TranslateService {

    // MARK: Singleton Property
    static var shared = TranslateService()

    // MARK: Init methods

    // Init private for Singleton
    private init() {}

    // init for testing purposes
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    // MARK: private properties

    // The URL for the request
    private var requestURL = "https://translation.googleapis.com/language/translate/v2"

    // The task for the request
    private var task: URLSessionDataTask?

    // The session for the request
    private var translateSession = URLSession(configuration: .default)

    // The Rate object to collect current rates
    //private var rates: Rate?
    private var request: Translate?

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
        guard let resultKey = dict["translateKey"] as? String else {
            return ""
        }
        return resultKey
    }

    // MARK: Private methods

    // Creating the request from the URL with accessKey
    private func createTranslateRequest(textToTranslate: String) -> URLRequest {
        requestURL += "?key=\(accessKey)&source=fr&target=en&q=\(textToTranslate)"
        print(requestURL)
        let translateUrl = URL(string: requestURL)!
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "GET"
        return request
    }

    private func getTextReadyForRequest(textToTranslate: String) -> String {
        let resultToSend: String = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return resultToSend
    }

    // MARK: Public methods

    // Refresh the ChangeRate. We need a closure on argument with:
    // - Type of error for result purpose
    // - String? contain the update date on european format
    // This method send the result to the rates variable
    func getTranslation(textToTranslate: String, callback: @escaping (Bool, String?) -> Void) {
        let textReady = getTextReadyForRequest(textToTranslate: textToTranslate)
        let request = createTranslateRequest(textToTranslate: textReady)
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.data.translations[0].translatedText )
            }
        }
        task?.resume()
        TranslateService.shared = TranslateService()
    }
}
