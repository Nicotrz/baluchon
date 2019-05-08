//
//  SettingsViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var currencyOriginPickerView: UIPickerView!
    @IBOutlet weak var currencyDestinationPickerView: UIPickerView!

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devises.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devises[row].descr
    }

    @IBAction func userPressedSetSettings(_ sender: Any) {
        ChangeService.shared.startingCurrency =
            devises[currencyOriginPickerView.selectedRow(inComponent: 0)].code
        ChangeService.shared.destinationCurrency =
            devises[currencyDestinationPickerView.selectedRow(inComponent: 0)].code
    }
}
