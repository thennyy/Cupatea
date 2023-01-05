//
//  AuthButton.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/21.
//

import UIKit

class AuthButton: UIButton {
  
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .accentColor

        layer.cornerRadius = 51/2
        heightAnchor.constraint(equalToConstant: 51).isActive = true
        isEnabled = false
        setTitleColor(.white, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
