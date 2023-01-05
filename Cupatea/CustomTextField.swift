//
//  CustomTextField.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/7/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String , isSecureField: Bool? = false, textcolor: UIColor = .accentColor){
        super.init(frame: .zero)
      
        let spacer = UIView()
        spacer.setDemensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        keyboardAppearance = .dark
        textColor = textcolor 
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 6
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 0, alpha: 0.3)])
        isSecureTextEntry = isSecureField!
        font = UIFont(name: .regular, size: 18)
       // backgroundColor = UIColor(white: 1, alpha: 0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
