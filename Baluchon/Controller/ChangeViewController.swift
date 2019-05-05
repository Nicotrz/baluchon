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

    private var isTextFieldNotEmpty: Bool {
        return !(numberToConvertTextField.text == "")
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        numberToConvertTextField.resignFirstResponder()
    }

    @IBAction func pressedConvert(_ sender: Any) {
        dismissKeyboard(sender)
        guard isTextFieldNotEmpty else {
            showAlert(message: "Veuillez introduire un montant")
            return
        }
        self.resultLabel.text =
        "$\(ChangeService.shared.convertCurrency(numberToConvert: numberToConvertTextField.text!))"
    }

    @IBAction func pressRefresh(_ sender: Any) {
        dismissKeyboard(sender)
        refreshRates()
    }

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

    private func changeStatusLoadingInterface(activate: Bool) {
        loadingActivityIndicator.isHidden = !activate
        refreshButton.isHidden = activate
        guard ChangeService.shared.ratesEnabled else {
            convertButton.isHidden = true
            return
        }
        convertButton.isHidden = activate
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
