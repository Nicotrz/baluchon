//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Nicolas Sommereijns on 03/05/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    // MARK: Private properties

    // Is the TextField properly filled?
    private var isTextFieldFilled: Bool {
        return translateTextField.text != ""
    }

    // MARK: Actions

    // The user pressed anywhere on screen
    @IBAction func userTappedOnScreen(_ sender: Any) {
        dismissKeyboard()
    }

    // The usser pressed on the translate button or "GO" on the keyboard
    @IBAction func userPressedTranslate(_ sender: Any) {
        dismissKeyboard()
        fetchTranslation()
    }

    // MARK: Private methods

    // Function to dismiss the keyboard
    private func dismissKeyboard() {
        translateTextField.resignFirstResponder()
    }

    // Function to (des)activate the loading interface
    private func switchLoadingInterface(activate: Bool) {
        translateButton.isHidden = activate
        loadingActivityIndicator.isHidden = !activate
    }

    // Function for fetching the translation from the model
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
