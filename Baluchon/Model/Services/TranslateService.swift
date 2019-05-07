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
        let translateUrl = URL(string: requestURL)!
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        return request
    }

    // This function translate the text in a version suitable for an URL Query
    // ( example: space are replaced by %20 )
    private func getTextReadyForRequest(textToTranslate: String) -> String {
        let resultToSend: String = textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return resultToSend
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
                let resultConvert = self.convertTextIntoAPrettyString(
                    textToConvert: responseJSON.data.translations[0].translatedText)
                guard resultConvert != [false: ""] else {
                    callback(false, nil)
                    return
                }
                callback(true, resultConvert[true])
            }
        }
        task?.resume()
        TranslateService.shared = TranslateService()
    }
}
