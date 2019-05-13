//
//  SettingsViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 07/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingChangeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var currencyOriginPickerView: UIPickerView!
    @IBOutlet weak var currencyDestinationPickerView: UIPickerView!

    // MARK: public methods

    // On viewDidLoad,we set by default the selection of changes on:
    // From: € (row 54)
    // To: USD (row 29)
    override func viewDidLoad() {
        currencyOriginPickerView.selectRow(54, inComponent: 0, animated: true)
        currencyDestinationPickerView.selectRow(29, inComponent: 0, animated: true)
        super.viewDidLoad()
    }

    // Number of components of the first picker => 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of elements => The number of devises elements
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devises.count
    }

    // The text => All of the description of devises
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devises[row].descr
    }

    // When the user stopped scrolling, we set the selection and send it to the model
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyOriginPickerView {
            let fromCurrency = devises[currencyOriginPickerView.selectedRow(inComponent: 0)].code
            ChangeService.shared.setCurrencies(fromCurrency: fromCurrency)
        } else {
            let toCurrency = devises[currencyDestinationPickerView.selectedRow(inComponent: 0)].code
            ChangeService.shared.setCurrencies(toCurrency: toCurrency)
        }
    }

}
