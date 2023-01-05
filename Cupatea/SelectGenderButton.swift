//
//  SelectGenderView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/31/21.
//

import UIKit

class SelectGenderButton: UIButton {

    convenience init(title: String) {
        self.init()
        
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = title
       // titleLabel.font = .regularMedium 
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self,
                           leftAnchor: leftAnchor,
                           rightAnchor: rightAnchor,
                           paddingLeft: 20,
                           paddingRight: 20)
        
      
        layer.cornerRadius = 12
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
    func selectedButton() {
        
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.accentColor.cgColor
        
    }
    func unSelectedButton() {
        
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.lightGray.cgColor
        
    }

    
}
