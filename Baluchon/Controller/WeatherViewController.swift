//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var localTemperatureLabel: UILabel!
    @IBOutlet weak var localConditionsLabel: UILabel!
    @IBOutlet weak var localCityNameLabel: UILabel!
    @IBOutlet weak var destinationTemperatureLabel: UILabel!
    @IBOutlet weak var destinationConditionsLabel: UILabel!
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        refreshWeather()
        super.viewDidLoad()
    }
    @IBAction func refreshButtonPressed(_ sender: Any) {
        refreshWeather()
    }

    private func toggleLoadingInterface(activate: Bool) {
        refreshButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }

    private func refreshWeather() {
        WeatherService.shared.getWeather(city: .getOrigin) { (successRequest1, resultRequest1) in
                guard successRequest1 else {
                    self.showAlert(message: "Erreur de connexion")
                    return
                }
                guard let unwrappedRequest1 = resultRequest1 else {
                    self.showAlert(message: "Erreur de connexion")
                    return
                }
                WeatherService.shared.getWeather(city: .getDestination) { (successRequest2, resultRequest2) in
                    guard successRequest2 else {
                        self.showAlert(message: "Erreur de connexion")
                        return
                    }
                    guard let unwrappedRequest2 = resultRequest2 else {
                        self.showAlert(message: "Erreur de connexion")
                        return
                    }
                    self.updateLabel(firstCity: unwrappedRequest1, secondCity: unwrappedRequest2)
                }
            }
    }

    // Display an alert with the message of our choices
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func updateLabel(firstCity: Weather, secondCity: Weather ) {
        localCityNameLabel.text = firstCity.name
        localTemperatureLabel.text = "\(String(firstCity.main.temp))°C"
        localConditionsLabel.text = firstCity.prettyDescriptionString
        destinationCityNameLabel.text = secondCity.name
        destinationTemperatureLabel.text = "\(String(secondCity.main.temp))°C"
        destinationConditionsLabel.text = secondCity.prettyDescriptionString
    }
}
