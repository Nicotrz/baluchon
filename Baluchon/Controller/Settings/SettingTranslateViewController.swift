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
        if pickerView == pickerOriginPickerViewController {
            TranslateService.shared.originLanguage =
                language[pickerOriginPickerViewController.selectedRow(inComponent: 0)].code
       } else {
            TranslateService.shared.destinationLanguage =
                language[pickerDestinationPickerViewController.selectedRow(inComponent: 0)].code
        }
    }
}
