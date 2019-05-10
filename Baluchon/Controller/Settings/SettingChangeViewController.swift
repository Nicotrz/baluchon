//
//  SettingsViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingChangeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var currencyOriginPickerView: UIPickerView!
    @IBOutlet weak var currencyDestinationPickerView: UIPickerView!

    override func viewDidLoad() {
        currencyOriginPickerView.selectRow(54, inComponent: 0, animated: true)
        currencyDestinationPickerView.selectRow(29, inComponent: 0, animated: true)
        super.viewDidLoad()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devises.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devises[row].descr
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyOriginPickerView {
            ChangeService.shared.startingCurrency =
                devises[currencyOriginPickerView.selectedRow(inComponent: 0)].code
        } else {
            ChangeService.shared.destinationCurrency =
                devises[currencyDestinationPickerView.selectedRow(inComponent: 0)].code
        }
    }

}
