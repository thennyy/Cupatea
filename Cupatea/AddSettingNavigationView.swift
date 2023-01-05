//
//  AddSettingNavigationView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit

 protocol AddSettingNavigationViewDelegate: AnyObject {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton)
 func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton)
    
}
class AddSettingNavigationView: UIView {
    
    weak var delegate: AddSettingNavigationViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Zodiac signs"
        let font = UIFont.regularBold
        label.font = font
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 9
        return label
        
    }()
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage.xmarkCircleImage
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.setDemensions(height: 27, width: 27)
        button.addTarget(self, action: #selector(handleLeftButton),
                         for: .touchUpInside)

        return button
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        let font = UIFont.regularBold
        button.titleLabel?.font = font
        
        button.tintColor = .accentColor
        button.addTarget(self, action: #selector(handleRightButton),
                         for: .touchUpInside)

        return button
    }()
    convenience init(title: String? = "", leftButton: UIImage, rightButton: String? = nil, delegate: AddSettingNavigationViewDelegate) {
        self.init()
        
        backgroundColor = .white 
        self.delegate = delegate
        titleLabel.text  = title
        self.leftButton.setImage(leftButton, for: .normal)
        self.rightButton.setTitle(rightButton, for: .normal)
            
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 1,paddingLeft: 1, paddingRight: 1,
                          height: 60)
        
        addSubview(self.leftButton)
        self.leftButton.centerY(inView: titleLabel,
                            leftAnchor: leftAnchor,
                            paddingLeft: 20)
        
        addSubview(self.rightButton)
        self.rightButton.centerY(inView: titleLabel,
                                 rightAnchor: rightAnchor,
                                 paddingRight: 20)
        
    }
    @objc func handleLeftButton(_ sender: UIButton) {
        self.delegate?.addSettingNavigationView(self, leftButton: sender)
    }
    @objc func handleRightButton(_ sender: UIButton) {
        self.delegate?.addSettingNavigationView(self, rightButton: sender)
        
    }
    
    func enableRightButton() {
        rightButton.isEnabled = true
    }
    func disableRightButton() {
        rightButton.isEnabled = false
    }
}
