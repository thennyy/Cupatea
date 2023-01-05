//
//  NeedEmailController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/9/22.
//

import UIKit

class NeedEmailController: UIViewController {
    
    private lazy var navigation = AddSettingNavigationView(leftButton: .backImage!, delegate: self)
    
    private let titleTitleLabel = UILabel()
    private let nextButton = KeepSwipingButton(type: .system)
    private var emailView = viweTemplates(image: "user",
                                         placeholder: "Phone number or Email",
                                       imageSize: 24, textFeildColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    func configureUI() {
        configureGradientLayer()
        titleTitleLabel.text = "What's your email address"
        titleTitleLabel.font = .funFactTitleBold
        titleTitleLabel.textColor = .white
        
        view.addSubview(titleTitleLabel)
        titleTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(emailView)
        emailView.anchor(top: titleTitleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20,
                         paddingLeft: 20, height: 54)
        
        nextButton.setTitle("Next", for: .normal)
        
//        view.addSubview(nextButton)
//        nextButton.anchor(top: emailView, left: emailView.leftAnchor, right: emailView.rightAnchor, height: 54)
//        
    }
}

extension NeedEmailController: AddSettingNavigationViewDelegate {
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
    }
    
}
