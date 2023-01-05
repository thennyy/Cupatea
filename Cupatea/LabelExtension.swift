//
//  LabelExtension.swift
//  EnterAct-Dating
//
//  Created by Thenny Chhorn on 10/15/21.
//

import UIKit

extension String {
    
    static let GTFont = "GTAmerica-Regular"
    static let GTBold = "GTAmerica-Bold"
    static let GTMedium = "GTAmerica-Medium"

}
extension UILabel {
    
    static let GTFont = "GTAmerica-Regular"
    static let GTBold = "GTAmerica-Bold"
    static let GTMedium = "GTAmerica-Medium"
    
    convenience init(numberOfLines: Int = 0, textColor: UIColor = .black,
                     text: String, fontSize: CGFloat, weight: FontWeight, alignment: NSTextAlignment = .center, height: CGFloat = 0) {
        self.init()
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.text = text
        self.textAlignment = alignment
        
        switch weight {
        case .regular:
            self.font = UIFont(name: .GTFont, size: fontSize)
        case .medium:
            self.font = UIFont(name: .GTMedium, size: fontSize)
        case .bold:
            self.font = UIFont(name: .GTBold, size: fontSize)
        }
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    enum FontWeight {
        case regular
        case medium
        case bold
    }
}

