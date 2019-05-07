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
    @IBOutlet weak var destinationTemperatureLabel: UILabel!
    @IBOutlet weak var destinationConditionsLabel: UILabel!
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
        WeatherService.shared.getWeather(city: .brussel) { (success, result) in
            guard success else {
                self.showAlert(message: "Erreur de connexion")
                return
            }
            self.localConditionsLabel.text = result![0]
            self.localTemperatureLabel.text = "\(result![1])°C"
        }
        WeatherService.shared.getWeather(city: .nyc) { (success, result) in
            guard success else {
                self.showAlert(message: "Erreur de connexion")
                return
            }
            self.destinationConditionsLabel.text = result![0]
            self.destinationTemperatureLabel.text = "\(result![1])°C"
        }
    }

    // Display an alert with the message of our choices
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
