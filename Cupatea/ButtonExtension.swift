//
//  ButtonExtension.swift
//  EnterAct_TEST
//
//  Created by Thenny Chhorn on 10/19/21.
//

import UIKit

extension UIButton {
    
    convenience init(image: String = "user", titleColor: UIColor = .white, color: UIColor = .white, text: String? = nil) {
        self.init()
        self.titleLabel?.text = text
        setTitleColor(titleColor, for: .normal)
        setImage(UIImage(named: image)!.withTintColor(color), for: .normal)
 
    }
    convenience init(titleColor: UIColor = .white, color: UIColor = .white, text: String? = nil, weight: SelectFont = .regular, fontSize: CGFloat = 18) {
        self.init()
    
        setTitle(text, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 45/2
        
        switch weight {
            
        case .bold:
            titleLabel?.font = UIFont(name: .bold , size: fontSize)
        case .medium:
            titleLabel?.font = UIFont(name: .medium , size: fontSize)
        case .regular:
            titleLabel?.font = UIFont(name: .regular , size: fontSize)
        }
    }
}
