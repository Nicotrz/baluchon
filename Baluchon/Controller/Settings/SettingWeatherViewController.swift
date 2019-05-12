//
//  SettingWeatherViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 10/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingWeatherViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerOriginPickerViewController: UIPickerView!
    @IBOutlet weak var pickerDestinationPickerViewController: UIPickerView!

    override func viewDidLoad() {
        pickerOriginPickerViewController.selectRow(38, inComponent: 0, animated: true)
        pickerDestinationPickerViewController.selectRow(122, inComponent: 0, animated: true)
        super.viewDidLoad()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row].city
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerOriginPickerViewController {
            WeatherService.shared.originCity =
                city[pickerOriginPickerViewController.selectedRow(inComponent: 0)].cityID
        } else {
            WeatherService.shared.destinationCity =
                city[pickerDestinationPickerViewController.selectedRow(inComponent: 0)].cityID
        }
    }
}
