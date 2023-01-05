//
//  ViewControllerExtension.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit

extension UIViewController {
    
    func alertMessage(_ message: String, answerButton: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: answerButton, style: .cancel))
        self.present(alert, animated: true)
    }
}
