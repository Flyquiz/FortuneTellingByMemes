//
//  Extensions.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 24.02.2024.
//

import UIKit

//MARK: Extensions for textField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension UIView {
    func addGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
}


//MARK: Extension for identifier
extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

