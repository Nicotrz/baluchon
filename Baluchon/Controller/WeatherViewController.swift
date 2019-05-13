//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var localTemperatureLabel: UILabel!
    @IBOutlet weak var localConditionsLabel: UILabel!
    @IBOutlet weak var localCityNameLabel: UILabel!
    @IBOutlet weak var destinationTemperatureLabel: UILabel!
    @IBOutlet weak var destinationConditionsLabel: UILabel!
    @IBOutlet weak var destinationCityNameLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    // MARK: Public methods

    // Override on viewDidLoad to fetch the weather at the loading
    override func viewDidLoad() {
        refreshWeather()
        super.viewDidLoad()
    }

    // MARK: Actions

    // The refresh button has been pressed
    @IBAction func refreshButtonPressed(_ sender: Any) {
        refreshWeather()
    }

    // MARK: Private methpds

    // (des)activate the loading interface
    private func toggleLoadingInterface(activate: Bool) {
        refreshButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }

    // Refresh the weather. First we fetch the origin weather
    // In case of success, we then fetch the destination
    // Finally, if the second one is successfull, we set the result on labels
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

    // Updating all the labels with Weather results objects
    private func updateLabel(firstCity: Weather, secondCity: Weather ) {
        localCityNameLabel.text = WeatherService.shared.getCityName(cityType: .getOrigin)
        localTemperatureLabel.text = "\(String(firstCity.main.temp))°C"
        localConditionsLabel.text = firstCity.prettyDescriptionString
        destinationCityNameLabel.text = WeatherService.shared.getCityName(cityType: .getDestination)
        destinationTemperatureLabel.text = "\(String(secondCity.main.temp))°C"
        destinationConditionsLabel.text = secondCity.prettyDescriptionString
    }

}
