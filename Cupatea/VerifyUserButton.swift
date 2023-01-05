//
//  VerifyUserButton.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/7/22.
//

import UIKit

class VerifyUserButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = .forwardImage
        iv.tintColor = .gray
        


        let iconImage = UIImageView()
        iconImage.image = .verifyImage
        iconImage.tintColor = .gray
        iconImage.contentMode = .scaleAspectFill

        addSubview(iconImage)
        iconImage.setDemensions(height: 21, width: 27)
        iconImage.centerY(inView: self,
                          leftAnchor: leftAnchor,
                          paddingLeft: 20)
        
        addSubview(iv)
        iv.setDemensions(height: 13, width: 13)
        iv.centerY(inView: self,
                   rightAnchor: rightAnchor,
                   paddingRight: 15)
        
        let textLabel = UILabel()
        textLabel.text = "Verify"
        textLabel.textColor = .gray
        textLabel.font = .regularMedium
        textLabel.textAlignment = .center
        
        addSubview(textLabel)
        textLabel.centerY(inView: self,
                          leftAnchor: iconImage.rightAnchor,
                          paddingLeft: 20)
        
     //   backgroundColor = .grayColor
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 15
        clipsToBounds = true 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
