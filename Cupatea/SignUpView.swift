//
//  SignUpView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/21.
//

import UIKit

class SignUpView: UIView {
    
    let titleLabel = UILabel(textColor: .accentColor, text: "Create \nAccount", fontSize: 30, weight: .bold, alignment: .left)
   
    let secondTitleLabel = UILabel(textColor: .gray,
                             text: "Please fill out your information",
                             fontSize: 18,
                             weight: .medium,
                             alignment: .left)
    
//    let emailView = InformationView()
//    let firstNameView = InformationView()
//    let passwordView = InformationView()
//    let repeatPasswordView = InformationView()

    let firstnameView = ViewTemplate(image: "user", placeholder: "First Name", imageSize: 24)
    let emailView = ViewTemplate(image: "address_book", placeholder: "Email", imageSize: 27)
    let passwordView = ViewTemplate(image: "lock", placeholder: "Password", imageSize: 27)
    let repeatPasswordView = ViewTemplate(image: "lock", placeholder: "Repeat Password", imageSize: 27)
    
    var termsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: .GTFont, size: 18)
        button.setTitle("View terms", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
       
        let stackView = UIStackView(arrangedSubviews: [firstnameView, emailView, passwordView, repeatPasswordView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 21
        return stackView
    }()
    lazy var titleStackView: UIStackView = {
       
        let stackView = UIStackView(arrangedSubviews: [titleLabel, secondTitleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 21
        return stackView
    }()
  
    let checkBoxView = ViewTemplate(image: "box", imageSize: 30, text: "Agreed with Terms and Conditions", textColor: .accentColor, weight: .medium, fontSize: 18)
    
    var doneButton = UIButton(titleColor: .white,
                              color: .accentColor,
                              text: "Done")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(titleStackView)
        titleStackView.anchor(top: topAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              paddingTop: 30,
                              paddingLeft: 45,
                              paddingRight: 51)
                             
        addSubview(stackView)
        stackView.anchor(top: titleStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 45, paddingRight: 45) 
        
        addSubview(termsButton)
        termsButton.anchor(top: stackView.bottomAnchor,
                           paddingTop: 30,
                           height: 30)
        termsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(checkBoxView)
        checkBoxView.anchor(top: termsButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, height: 100)
        
        addSubview(doneButton)
        doneButton.anchor(top: checkBoxView.bottomAnchor, paddingTop: 30, width: 150, height: 45)
        doneButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
