//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var numberToConvertTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var refreshDateLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!

    // MARK: Private properties

    // Is the Input text field Empty?
    private var isTextFieldNotEmpty: Bool {
        return !(numberToConvertTextField.text == "")
    }

    // Is the Input text field Valid?
    private var isTextFieldValid: Bool {
        var comaCount = 0
        guard let textField = numberToConvertTextField.text else {
            return false
        }
        for character in textField where character == "," {
                comaCount += 1
        }
        return ( !(comaCount > 1) && !( textField.count > 10 ) )
    }

    // MARK: Actions

    // When the user press anywhere outside the keyboard area
    @IBAction func touchView(_ sender: Any) {
        dismissKeyboard()
    }

    // When the user press the button to convert the price
    @IBAction func pressedConvert(_ sender: Any) {
        dismissKeyboard()
        guard isTextFieldNotEmpty else {
            showAlert(message: "Veuillez introduire un montant")
            return
        }
        guard isTextFieldValid else {
            showAlert(message: "Veuillez introduire un montant valide")
            return
        }
        self.resultLabel.text =
        "\(ChangeService.shared.convertCurrency(numberToConvert: numberToConvertTextField.text!))"
    }

    // When the user press the button to refresh the rates
    @IBAction func pressRefresh(_ sender: Any) {
        dismissKeyboard()
        refreshRates()
    }

    // MARK: private methods

    // Dismiss the keyboard
    private func dismissKeyboard() {
        numberToConvertTextField.resignFirstResponder()
    }

    // Refresh the rates and display an error if not successfull
    private func refreshRates() {
        changeStatusLoadingInterface(activate: true)
        ChangeService.shared.refreshChangeRate { (errorCase, updateDate) in
            switch errorCase {
            case .alreadyRefreshed:
                self.showAlert(message: "Les taux sont déjà à jour")
            case .networkError:
                self.showAlert(message: "Erreur de connexion")
            case .requestSuccessfull:
                self.refreshDateLabel.text = updateDate
            }
            self.changeStatusLoadingInterface(activate: false)
        }
    }

    // Showing or hiding the loading interface
    // Warning: if the rates are not available, we does not let the convert button appear
    private func changeStatusLoadingInterface(activate: Bool) {
        loadingActivityIndicator.isHidden = !activate
        refreshButton.isHidden = activate
        guard ChangeService.shared.ratesEnabled else {
            convertButton.isHidden = true
            return
        }
        convertButton.isHidden = activate
    }

    // Display an alert with the message of our choices
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
