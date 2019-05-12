//
//  SettingTranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 10/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class SettingTranslateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerOriginPickerViewController: UIPickerView!
    @IBOutlet weak var pickerDestinationPickerViewController: UIPickerView!

    override func viewDidLoad() {
        pickerOriginPickerViewController.selectRow(29, inComponent: 0, animated: true)
        pickerDestinationPickerViewController.selectRow(4, inComponent: 0, animated: true)
        super.viewDidLoad()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row].descr
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard pickerOriginPickerViewController.selectedRow(inComponent: 0) != pickerDestinationPickerViewController.selectedRow(inComponent: 0) else {
            showAlert(message: "Les deux langues ne peuvent pas être identiques!")
            return
        }
        if pickerView == pickerOriginPickerViewController {
            TranslateService.shared.originLanguage =
                language[pickerOriginPickerViewController.selectedRow(inComponent: 0)].code
       } else {
            TranslateService.shared.destinationLanguage =
                language[pickerDestinationPickerViewController.selectedRow(inComponent: 0)].code
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
