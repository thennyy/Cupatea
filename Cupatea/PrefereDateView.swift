//
//  PrefereDateView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit
enum DatePreferenceSection {
    case men
    case women
    case everyone
}
class PrefereDateView: UIView {
    
    private var isCheck = false
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .regularMedium
        label.text = "Fun activities and such..."

        return label
    }()
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(.unCheckMarkImage, for: .normal)
        button.setDemensions(height: 54, width: 54)
        button.addTarget(self, action: #selector(handleCheckButton),
                         for: .touchUpInside)
        return button
    }()
    
    convenience init(title: String) {
        self.init()
        
        backgroundColor = .grayColor
        layer.cornerRadius = 15
        
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.centerY(inView: self,
                           leftAnchor: leftAnchor,
                           paddingLeft: 20)
        
        addSubview(checkBoxButton)
        checkBoxButton.centerY(inView: self,
                               rightAnchor: rightAnchor,
                               paddingRight: 9)
        
    }
    
    @objc func handleCheckButton(_ sender: UIButton) {
        
        if isCheck == false {
            isCheck = true
            checkBoxButton.setImage(.checkMarkImage, for: .normal)
            checkBoxButton.tintColor = .accentColor
        }else {
            isCheck = false
            checkBoxButton.setImage(.unCheckMarkImage, for: .normal)
            checkBoxButton.tintColor = .lightGray
        }
    }
   
}
