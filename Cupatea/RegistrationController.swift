//
//  RegistrationController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/3/21.
//
import UIKit
import JGProgressHUD
import Firebase
import SDWebImage

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: AuthenticationDelegate?
  
    var profileImage: UIImage?
    
    private var viewModel = RegistrationViewModel()
    
    private let titleLabel = UILabel(numberOfLines: 0,
                                     textColor: .accentColor,
                                     text: "Create Account",
                                     fontSize: 30,
                                     weight: .bold,
                                     alignment: .center, height: 60)
   
    private let secondTitleLabel = UILabel(textColor: .gray,
                             text: "Please fill out your information",
                             fontSize: 18,
                             weight: .medium,
                             alignment: .left, height: 30)
    
    let firstnameView = viweTemplates(image: "user",
                                     placeholder: "First Name",
                                      imageSize: 24,
                                      textFeildColor: .white)
    
    let emailView = viweTemplates(image: "address_book",
                                 placeholder: "Email",
                                  imageSize: 27,
                                  textFeildColor: .white)
    
    let passwordView = viweTemplates(image: "lock",
                                    placeholder: "Password",
                                     isSecured: true,
                                     imageSize: 27, textFeildColor: .white)
    
    
    private let termsButton = UIButton(titleColor: .lightGray,
                                       color: .clear,
                                       text: "View Terms")
    
    private let closeButton = UIButton(image: "close",
                                       color: .accentColor)
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addPhoto")?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
        button.backgroundColor = UIColor(white: 0, alpha: 0.113)
        button.addTarget(self, action: #selector(handleSelectPhotoButton),
                         for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 150/2
        
        return button
        
    }()
    lazy var stackView: UIStackView = {
       
        let stackView = UIStackView(arrangedSubviews: [firstnameView,
                                                       emailView,
                                                       passwordView,
                                                       doneButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
        
    }()
    
    let checkBoxView = ViewTemplate(image: "box",
                                    imageSize: 30,
                                    text: "Agreed with Terms and Conditions",
                                    textColor: .accentColor,
                                    weight: .medium,
                                    fontSize: 18)
    

    private lazy var doneButton:  AuthButton = {
    
        let button = AuthButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: .bold, size: 18)
        button.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        return button
    }()
    
    private lazy var goToLoginButton: UIButton = {
        
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [.foregroundColor: UIColor.accentColor])
        attributeTitle.append(NSAttributedString(string: " Sign In", attributes: [.foregroundColor: UIColor.accentColor, .font: UIFont(name: .medium, size: 18)!]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: -  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
    }
    
    //MARK: - Selectors
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= 88
        }
    }
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc func handleRegisterUser() {
     
        guard let email = emailView.textField.text else {return}
        guard let name = firstnameView.textField.text else {return}
        guard let password = passwordView.textField.text else {return}
        guard let profileImage = self.profileImage else {return}
        
        let credential = AuthCredential(email: email, password: password, name: name, profileImage: profileImage)
     
        showLoader(true,withText: "Loading")
        
        AuthService.registerUser(withCredential: credential) { error in
            if let error = error {
                print("DEBUG: ERROR SIGNING UP USER \(error.localizedDescription)")
                self.alertUserErrorMessage(message: error.localizedDescription)
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.delegate?.authenticationComplete() 
        }
    }
    @objc func handleBackButton() {
        print("LOG IN ")
        navigationController?.popViewController(animated: true)
        
    }
    @objc func handleSelectPhotoButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    @objc func handleTextChange(sender: UITextField) {
        if sender == emailView.textField {
            viewModel.email = sender.text
        }else if sender == passwordView.textField {
            viewModel.password = sender.text
        }else {
            viewModel.name = sender.text
        }
        checkFormStatus()
    }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            doneButton.isEnabled = true
        }else {
            doneButton.isEnabled = false
        }
    }
    
    //MARK: - Helpers

    func configureUI() {
        
        configureGradientLayer()
        navigationController?.navigationBar.tintColor = .defaultGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(handleBackButton))
                                                           
        view.backgroundColor = .white
        view.addSubview(selectPhotoButton)
        emailView.textField.delegate = self
        firstnameView.textField.delegate = self
        passwordView.textField.delegate = self
        selectPhotoButton.setDemensions(height: 150, width: 150)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.topAnchor, paddingTop: 60)
        
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 30,
                         paddingLeft: 45,
                         paddingRight: 45)

        view.addSubview(doneButton)
        doneButton.anchor(top: stackView.bottomAnchor,
                          left: stackView.leftAnchor,
                          right: stackView.rightAnchor,
                          paddingTop: 60,
                          height: 51)
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)

        
    }
    
    func configureNotificationObserver() {
        
        emailView.textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingChanged)
        passwordView.textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingChanged)

        firstnameView.textField.addTarget(self, action: #selector(handleTextChange(sender:)), for: .editingChanged)

    }

}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderWidth = 1.5
        selectPhotoButton.layer.borderColor = UIColor.white.cgColor
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailView.textField.resignFirstResponder()
        firstnameView.textField.resignFirstResponder()
        passwordView.textField.resignFirstResponder()
    }
}
