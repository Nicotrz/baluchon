//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    private var isTextFieldFilled: Bool {
        return translateTextField.text != ""
    }
    @IBAction func userTappedOnScreen(_ sender: Any) {
        dismissKeyboard()
    }

    @IBAction func userPressedTranslate(_ sender: Any) {
        dismissKeyboard()
        fetchTranslation()
    }

    @IBAction func userPressedGoOnKeyboard(_ sender: Any) {
        dismissKeyboard()
        fetchTranslation()
    }

    private func dismissKeyboard() {
        translateTextField.resignFirstResponder()
    }

    private func switchLoadingInterface(activate: Bool) {
        translateButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }

    private func fetchTranslation() {
        guard isTextFieldFilled else {
            showAlert(message: "Veuillez introduire la phrase à traduire")
            return
        }
        switchLoadingInterface(activate: true)
        TranslateService.shared.getTranslation(textToTranslate: translateTextField.text!) { (success, translation) in
            if success {
                self.resultLabel.text = translation
            } else {
                self.showAlert(message: "Erreur de connexion")
            }
        }
        switchLoadingInterface(activate: false)
    }

    // Display an alert with the message of our choices
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
