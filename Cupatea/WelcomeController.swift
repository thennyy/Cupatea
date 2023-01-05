//
//  WelcomeController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/21/22.
//

import UIKit

class WelcomeController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: AuthenticationDelegate?

    private let titleImageView: UIImageView = {
        
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.image = UIImage(named: "title")?.withTintColor(.white)
      
        image.contentMode = .scaleAspectFit
        
        return image
        
    }()

    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.image = UIImage(named: "cupateaLogo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let phoneIconImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(systemName: "iphone")
        iv.tintColor = .defaultGray
        iv.image = image
        
        return iv
    }()
    private let emailIconImageView : UIImageView = {
        let iv = UIImageView()
        let image = UIImage(systemName: "network")
        iv.tintColor = .defaultGray
        iv.image = image
        
        return iv
    }()
    private lazy var authWithPhoneNumberBtn: AuthButton = {
        let button = AuthButton(type: .system)
        button.isEnabled = true
        button.setTitle("Log in with phone number", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
      //  button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private lazy var authWithEmailBtn: AuthButton = {
        let button = AuthButton(type: .system)
        button.isEnabled = true
        button.setTitle("Log in with Email", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(handleLoginWithEmail), for: .touchUpInside)
        return button
    }()
    private lazy var goToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account", attributes: [.foregroundColor: UIColor.accentColor])
        attributeTitle.append(NSAttributedString(string: " Sign Up", attributes: [.foregroundColor: UIColor.accentColor, .font: UIFont(name: .medium, size: 18)!]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        
        return button
    }()

    private lazy var signInStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authWithPhoneNumberBtn, authWithEmailBtn])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        configureGradientLayer()
        view.backgroundColor = .accentColor

        view.addSubview(titleImageView)
        titleImageView.centerX(inView: view)
        titleImageView.setDemensions(height: 90,
                                     width: view.frame.width)
        titleImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDemensions(height: 150,
                                width: 150)
        iconImage.anchor(top: titleImageView.bottomAnchor,
                         paddingTop: 30)
        
        view.addSubview(goToRegisterButton)
        goToRegisterButton.anchor(left: view.leftAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor,
                                  paddingLeft: 30,
                                  paddingBottom: 15,
                                  paddingRight: 30)
        
        view.addSubview(signInStackView)
        signInStackView.anchor(left: view.leftAnchor,
                               bottom: goToRegisterButton.topAnchor,
                               right: view.rightAnchor,
                               paddingLeft: 45,
                               paddingBottom: 45,
                               paddingRight: 45)
        
      
        view.addSubview(phoneIconImageView)
        phoneIconImageView.setDemensions(height: 27, width: 27)
        phoneIconImageView.centerY(inView: authWithPhoneNumberBtn,
                                   leftAnchor: authWithEmailBtn.leftAnchor,
                                   paddingLeft: 12)
        
        view.addSubview(emailIconImageView)
        emailIconImageView.setDemensions(height: 27,
                                         width: 27)
        
        emailIconImageView.centerY(inView: authWithEmailBtn,
                                   leftAnchor: authWithEmailBtn.leftAnchor,
                                   paddingLeft: 12)
        
        
    }
    // MARK: - Selectors
    
    @objc
    private func handleShowRegister() {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func handleLoginWithEmail() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
