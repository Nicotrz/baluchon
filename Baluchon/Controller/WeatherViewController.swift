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
    

    @IBAction func refreshButtonPressed(_ sender: Any) {
    }
}
