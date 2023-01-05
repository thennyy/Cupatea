//
//  CustomTitleLabel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/5/22.
//

import UIKit

class CustomTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let insertText = text ?? ""
        textColor = .black
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: insertText,
                                                  attributes: [.font: font!])
        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0,length: attribute.length - 1))
        
        attributedText = attribute
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
