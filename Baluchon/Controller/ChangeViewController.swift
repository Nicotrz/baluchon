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
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        let numberFormated = formatter.number(from: self.numberToConvertTextField.text!)
        guard let toConvert = numberFormated?.doubleValue else {
            return
        }
        if ChangeService.rates == nil {
            ChangeService.shared.refreshChangeRate { (success, rates) in
                DispatchQueue.main.async {
                    if success, let rates = rates {
                        ChangeService.rates = rates
                        self.resultLabel.text =
                        "\(String(ChangeService.shared.convertCurrency(numberToConvert: toConvert)))$"
                    }
                }
            }
        } else {
            self.resultLabel.text =
            "\(String(ChangeService.shared.convertCurrency(numberToConvert: toConvert)))$"
        }
    }
}
