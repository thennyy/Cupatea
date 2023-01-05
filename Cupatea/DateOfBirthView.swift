//
//  VerifyAgeView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/30/21.
//

import UIKit

class DateOfBirthView: UIView {

    let titleLabel = UILabel(textColor: .accentColor,
                             text: "Date of Birth",
                             fontSize: 30,
                             weight: .bold)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 21, paddingRight: 21, width: 0, height:90)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
