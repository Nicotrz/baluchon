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

    @IBAction func refreshButtonPressed(_ sender: Any) {
        WeatherService.shared.getWeather(city: .brussel) { (success, result) in
            if success {
                self.localConditionsLabel.text = result![0]
                self.localTemperatureLabel.text = "\(result![1])°C"
            }
        }
        WeatherService.shared.getWeather(city: .nyc) { (success, result) in
            if success {
                self.destinationConditionsLabel.text = result![0]
                self.destinationTemperatureLabel.text = "\(result![1])°C"
            }
        }
    }

    private func toggleLoadingInterface(activate: Bool) {
        refreshButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }
}
