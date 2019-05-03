//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {
    @IBOutlet weak var numberToConvertTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    @IBAction func dismissKeyboard(_ sender: Any) {
        numberToConvertTextField.resignFirstResponder()
    }

    @IBAction func pressedConvert(_ sender: Any) {
        let toConvert = Double(numberToConvertTextField.text!)!
        resultLabel.text = String(ChangeService.shared.convertCurrency(numberToConvert: toConvert))
    }
}
