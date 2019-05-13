//
//  SettingWeatherViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 10/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingWeatherViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var pickerOriginPickerViewController: UIPickerView!
    @IBOutlet weak var pickerDestinationPickerViewController: UIPickerView!

    // MARK: Public methods

    // On viewDidLoad, we set the pickers by default:
    // From: Brussels, BE (row 38)
    // To: N-Y, USA (row 122)
    override func viewDidLoad() {
        pickerOriginPickerViewController.selectRow(38, inComponent: 0, animated: true)
        pickerDestinationPickerViewController.selectRow(122, inComponent: 0, animated: true)
        super.viewDidLoad()
    }

    // Number of components of the pickers: 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of elements: the number of cities
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city.count
    }

    // The text to show: name of the city
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row].city
    }

    // When the user stopped the weel, we send the choice to the model
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerOriginPickerViewController {
            let originCity =
                city[pickerOriginPickerViewController.selectedRow(inComponent: 0)].cityID
            WeatherService.shared.setOriginCity(originCity: originCity)
        } else {
            let destinationCity =
                city[pickerDestinationPickerViewController.selectedRow(inComponent: 0)].cityID
            WeatherService.shared.setDestinationCity(destinationCity: destinationCity)
        }
    }
}
