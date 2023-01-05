//
//  ProfileCompletionPercentageView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/7/22.
//

import UIKit

class ProfileCompletionView: UIButton {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
    convenience init(text: String) {
        self.init()
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = .forwardImage
        iv.tintColor = .gray
        
        addSubview(iv)
        iv.setDemensions(height: 13, width: 13)
        iv.centerY(inView: self,
                      rightAnchor: rightAnchor,
                      paddingRight: 15)
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textColor = .gray
        textLabel.font = .regularMedium
        textLabel.textAlignment = .center
        
        addSubview(textLabel)
        textLabel.centerY(inView: self,
                          leftAnchor: leftAnchor,
                          paddingLeft: 20)
        
        backgroundColor = .grayColor
      
       // layer.borderColor = UIColor.lightGray.cgColor
       // layer.borderWidth = 3
        layer.cornerRadius = 15
        clipsToBounds = true
    
    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
