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
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var refreshDateLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    override func viewDidLoad() {
        refreshRates()
        super.viewDidLoad()
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        numberToConvertTextField.resignFirstResponder()
    }

    @IBAction func pressedConvert(_ sender: Any) {
        dismissKeyboard(sender)
        guard checkIfTextFieldIsNotEmpty() else {
            showAlert(message: "Veuillez introduire un montant")
            return
        }
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        let numberFormated = formatter.number(from: self.numberToConvertTextField.text!)
        guard let toConvert = numberFormated?.doubleValue else {
            return
        }
            convertAndShowResult(toConvert: toConvert)
    }

    @IBAction func pressRefresh(_ sender: Any) {
        refreshRates()
    }

    private func refreshRates() {
        changeStatusLoadingInterface(activate: true)
        ChangeService.shared.refreshChangeRate { (success, rates) in
            DispatchQueue.main.async {
                self.changeStatusLoadingInterface(activate: false)
                guard success, let rates = rates else {
                    self.showAlert(message: "Erreur de connexion")
                    return
                }
                ChangeService.rates = rates
                self.refreshDateLabel.text = self.changeDateFormat(date: ChangeService.rates?.date ?? "2000-01-01")
            }
        }
    }

    private func convertAndShowResult(toConvert: Double) {
        self.resultLabel.text =
        "$\(String(ChangeService.shared.convertCurrency(numberToConvert: toConvert)))"
    }

    private func changeStatusLoadingInterface(activate: Bool) {
       convertButton.isHidden = activate
        refreshButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }

    private func checkIfTextFieldIsNotEmpty() -> Bool {
        if numberToConvertTextField.text == "" {
            return false
        } else {
        return true
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func changeDateFormat(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/YYYY"
        let showDate = inputFormatter.date(from: date)
        return outputFormatter.string(from: showDate!)
    }
}
