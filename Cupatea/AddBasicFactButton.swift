//
//  AddBasicFactButton.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

enum BasicFactSection {
    
    case ethnicity
    case height
    case starSign
    case seeking
    case religion
    case exercise
    
}

class AddBasicFactButton: UIButton {
    
    var viewModel: SettingsViewModel! {
        didSet{
            configureData()
        }
    }
    private var section: BasicFactSection?
    
    private let textLabel = UILabel()
    private let iconImageView = UIImageView()
    
    convenience init(iconImage: UIImage, text: String, section: BasicFactSection) {
        self.init()
        self.section = section
        
        
        iconImageView.image = iconImage.withTintColor(.black)
        iconImageView.setDemensions(height: 30, width: 30)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        
        addSubview(iconImageView)
        iconImageView.centerX(inView: self,
                          topAnchor: topAnchor,
                          paddingTop: 20)
        
        textLabel.text = text
        textLabel.textColor = .lightGray
        textLabel.textAlignment = .center
        addSubview(textLabel)
        textLabel.anchor(top: iconImageView.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: 6,
                         paddingRight: 6)
        
        backgroundColor = .grayColor
        layer.cornerRadius = 20
        clipsToBounds = true
        
    }
    
    func configureData() {
        
        guard let section = self.section else {return}
        
        switch section {
        case .ethnicity:
            if viewModel.ethicity.isEmpty == false {
                configureTextAttribute(value: viewModel.ethicity)
                textLabel.text = viewModel.ethicity
            }
        case .height:
            if viewModel.height.isEmpty == false {
                configureTextAttribute(value: viewModel.height)
                textLabel.text = viewModel.height
            }
        case .starSign:
            if viewModel.starSign.isEmpty == false {
                configureTextAttribute(value: viewModel.starSign)
                textLabel.text = viewModel.starSign
                iconImageView.image = UIImage(named: "\(viewModel.starSign)")
            }
        case .seeking:
            if viewModel.seeking.isEmpty == false {
                configureTextAttribute(value: viewModel.seeking)
                textLabel.text = viewModel.seeking
            }
        case .religion:
            if viewModel.religion.isEmpty == false {
                configureTextAttribute(value: viewModel.religion)
                textLabel.text = viewModel.religion
            }
        case .exercise:
            if viewModel.excercise.isEmpty == false {
                configureTextAttribute(value: viewModel.excercise)
                textLabel.text = viewModel.excercise
            }
        }
    }
    
    func configureTextAttribute(value: String) {
        
        if value.isEmpty == false {
            
            textLabel.font = .smallMedium
            textLabel.numberOfLines = 2
            textLabel.textColor = .black
            
        }
    }
}
