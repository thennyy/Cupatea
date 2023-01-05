//
//  LoginController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/3/21.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}
class LoginController: UIViewController {
   
    //MARK: - Properties
    private var viewModel = LoginViewModel()
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
        image.image = UIImage(named: "logo1")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"),
                        for: .normal)
        button.tintColor = .defaultGray
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    private var emailView = viweTemplates(image: "user",
                                         placeholder: "Phone number or Email",
                                       imageSize: 24, textFeildColor: .white)
    private var passwordView = viweTemplates(image: "lock",
                                            placeholder: "Password",
                                             isSecured: true,
                                            imageSize: 27,
                                          addLine: .addLine, textFeildColor: .white)

    private lazy var signInStackView: UIStackView = {
        
     let stackView = UIStackView(arrangedSubviews: [emailView, passwordView])
    
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private lazy var authButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: .bold, size: 18)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
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
    lazy var forgotPasswordButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = UIFont(name: .regular, size: 18)
      //  button.backgroundColor = .accentColor
        button.setTitleColor(.accentColor, for: .normal)
       // button.layer.cornerRadius = 51/2
        return button
        
    }()
    //MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI() 
        configureNotificationObserver()
    }
    // MARK: - Selectors
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0{
            view.frame.origin.y -= 88
        }
    }
    @objc func keyboardWillHide(){
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    @objc func handleLogin(){
        print("LOGGING IN")
        guard let email = emailView.textField.text else {return}
        guard let password = passwordView.textField.text else {return}
        
        showLoader(true, withText: "Logging in")
        print("DEBUG: LOADING DATA FOR THE THIS APP ")
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("DEBUG: FAILED TO LOG IN \(error.localizedDescription)")
                self.showLoader(false)
                let error = error.localizedDescription
                self.alertUserErrorMessage(message: error)
                return
            }
            self.showLoader(false)
            self.delegate?.authenticationComplete()
            self.dismiss(animated: true)
        }
  
      
    }
    @objc func handleShowRegister() {
        let vc = RegistrationController()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func handleTextChange(sender: UITextField) {
        if sender == emailView.textField {
            viewModel.email = sender.text
        }else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    @objc
    private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            authButton.isEnabled = true
        }else {
            authButton.isEnabled = false
        }
    }

    func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        
        configureGradientLayer()
        
        view.addSubview(titleImageView)
        titleImageView.setDemensions(height: 60, width: view.frame.width)
        titleImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDemensions(height: 60, width: 60)
        iconImage.anchor(top: titleImageView.bottomAnchor,
                         paddingTop: 15)
        
        view.addSubview(signInStackView)
        signInStackView.anchor(top: iconImage.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 45,
                               paddingLeft: 45,
                               paddingRight: 45)

        view.addSubview(authButton)
        authButton.anchor(top: signInStackView.bottomAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingTop: 45,
                          paddingLeft: 45,
                          paddingRight: 45,
                          height: 51)

        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top: authButton.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    paddingTop: 45,
                                    paddingLeft: 45,
                                    paddingRight: 45,
                                    height: 51)
        
        view.addSubview(goToRegisterButton)
        goToRegisterButton.anchor(left: view.leftAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor,
                                  paddingLeft: 45,
                                  paddingRight: 45)

    }
    
    func configureNotificationObserver() {
        
        emailView.textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingChanged)
        passwordView.textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
  
}

// MARK: - UITextFieldDelegate

extension LoginController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailView.textField.resignFirstResponder()
        passwordView.textField.resignFirstResponder()
    }
}
