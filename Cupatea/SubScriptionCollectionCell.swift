//
//  SubScriptionCollectionCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

class SubScriptionCollectionCell: UICollectionViewCell {
   
    static let identifier = "subscriptionCollectioncell"
    let backGroundView = UIView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            
        }
    }
     let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = "VIP"
        let font = UIFont.titleMedium
        label.font = font
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])

        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0, length: attribute.length - 1))
       
         label.attributedText = attribute
        
        return label
    }()
    
    let secondTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .regularMedium
        label.text = "Get to know more this person more..."

        return label
    }()
    lazy var selectPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Only $8.99", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.regularMedium 
        button.backgroundColor = .shareColor
        button.layer.cornerRadius = 39/2
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightAcentColor.cgColor
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        
        layer.cornerRadius = 20
        clipsToBounds = true
        
        backGroundView.layer.borderColor = UIColor.lightAcentColor.cgColor
        backGroundView.layer.borderWidth = 1
        backGroundView.layer.cornerRadius = 20
        
        addSubview(backGroundView)
        backGroundView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 6,
                              paddingLeft: 6,
                              paddingBottom: 6,
                              paddingRight: 6)
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          left: leftAnchor,
                          paddingTop: 26,
                          paddingLeft: 26)
        
        addSubview(secondTitle)
        secondTitle.anchor(top: titleLabel.bottomAnchor,
                           left: titleLabel.leftAnchor,
                           right: rightAnchor,
                           paddingTop: 9,
                           paddingLeft: 9,
                           paddingRight: 9)
        
        contentView.addSubview(selectPriceButton)
        selectPriceButton.anchor(left: leftAnchor,
                                 bottom: contentView.bottomAnchor,
                                 paddingLeft: 26,
                                 paddingBottom: 20,
                                 width: 120,
                                 height: 39)
        
    }
    
}
