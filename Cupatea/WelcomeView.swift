//
//  WelcomeView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/30/21.
//

import UIKit

class WelcomeView: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Welcome to\nCupa Tea"
        label.numberOfLines = 0
        label.font = .titleBold
        label.textColor = .accentColor
        return label
    }()
    let welcomeLabel = UILabel(textColor: .accentColor,
                               text: "Welcome to\nCupa Tea",
                               fontSize: 30,
                               weight: .bold, alignment: .left)
                            
    let titleLabel = UILabel(textColor: .darkGray,
                             text: "We are excited to meet you",
                             fontSize: 18,
                             weight: .medium,
                             alignment: .left)
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 9
       // setDemensions(height: 300, width: frame.width)
        return stackView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(label)

        label.anchor(top: topAnchor, left: leftAnchor,bottom: bottomAnchor,
                     right: rightAnchor)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
