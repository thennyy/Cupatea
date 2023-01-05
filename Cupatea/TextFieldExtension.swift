//
//  TextFieldExtension.swift
//  EnterAct-Dating
//
//  Created by Thenny Chhorn on 10/17/21.
//

import UIKit

extension UITextField {
    
    convenience init(placeHolder: String, textColor: UIColor) {
        self.init()
        self.textColor = textColor
        self.placeholder = placeHolder 
        
    }
}
