//
//  SettingTranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 10/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingTranslateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var pickerOriginPickerViewController: UIPickerView!
    @IBOutlet weak var pickerDestinationPickerViewController: UIPickerView!

    // MARK: Public methods

    // When loading the view, we show by default on the pickers:
    // From: French (row 29)
    // To: English (row: 4)
    override func viewDidLoad() {
        pickerOriginPickerViewController.selectRow(29, inComponent: 0, animated: true)
        pickerDestinationPickerViewController.selectRow(4, inComponent: 0, animated: true)
        super.viewDidLoad()
    }

    // Number of component of the pickers: 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of elements: count on language
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }

    // Text: the description of each language
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row].descr
    }

    // When the user select a row, we send this row to the model.
    // Warning: we check first that the origin and destination languages
    // Are not the same
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let originLanguage =
            language[pickerOriginPickerViewController.selectedRow(inComponent: 0)].code
        let destinationLangage =
            language[pickerDestinationPickerViewController.selectedRow(inComponent: 0)].code
        guard originLanguage != destinationLangage else {
            showAlert(message: "Les deux langues ne peuvent pas être identiques!")
            return
        }
        if pickerView == pickerOriginPickerViewController {
            TranslateService.shared.setOriginLanguage(fromLanguage: originLanguage)
       } else {
            TranslateService.shared.setDestinationLanguage(toLanguage: destinationLangage)
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
