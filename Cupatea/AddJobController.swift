//
//  AddInfoController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/31/22.
//

import UIKit
protocol AddJobControllerDelegate: AnyObject {
    func addJobController(_ controllerWantsToUpdate: AddJobController, user: User)
}
class AddJobController: UIViewController {
    
    // MARK: - Properties
    var user: User! {
        
        didSet {

            if user.profession.isEmpty == false {
                self.addJobTextField.text = user.profession
                Service.countingOccupationWord(self.addJobTextField) { wordCount in
                    self.jobWordCountView.wordCountLabel.text = wordCount
                    
                }
            }
            if user.profession.isEmpty == false {
                self.companyTextField.text = user.company
                Service.countingOccupationWord(self.companyTextField) { wordCount in
                    self.companyWordCountView.wordCountLabel.text = wordCount
                }
            }

        }
    }
    
    weak var delegate: AddJobControllerDelegate?
    
    private let backGroundView = UIView()
    
    private let jobWordCountView = WordCountView(wordCount: "50")
    private let companyWordCountView = WordCountView(wordCount: "50")
    
    private lazy var navigationView = AddSettingNavigationView(title: "Occupation",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save",
                                                               delegate: self)
    
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Ocupation"
        let font = UIFont.regularBold
        label.font = font
        label.textAlignment = .center

        return label
        
    }()
   
    private let addTextTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .gray
        label.text = "Write here..."

        return label
    }()
 
    
    private lazy var addJobTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add a job"
        tf.layer.cornerRadius = 45/2
        tf.backgroundColor = .grayColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: 20,
                                            height: 40))
        tf.leftViewMode = .always
        tf.leftView = leftView
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleEnableTextField),
                     for: .editingChanged)
        return tf
    }()
    private lazy var companyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Company/field"
        tf.layer.cornerRadius = 45/2
        tf.backgroundColor = .grayColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: 20,
                                            height: 40))
        
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleEnableTextField),
                     for: .editingChanged)
        
        return tf
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addJobTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .white
      //  view.isOpaque = false
        
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)
        
        view.addSubview(addJobTextField)
        addJobTextField.anchor(top: navigationView.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 51,
                        paddingLeft: 20,
                        paddingRight: 20, height: 45)
        
        view.addSubview(jobWordCountView)
        jobWordCountView.anchor(bottom: addJobTextField.topAnchor,
                                right: addJobTextField.rightAnchor,
                                height: 30)
        
        view.addSubview(companyTextField)
        companyTextField.anchor(top: addJobTextField.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 36,
                        paddingLeft: 20,
                        paddingRight: 20, height: 45)
        
        
        view.addSubview(companyWordCountView)
        companyWordCountView.anchor(bottom: companyTextField.topAnchor,
                                right: companyTextField.rightAnchor,
                                height: 30)

        
    }
    
    // MARK: - Actions

    @objc func handleEnableTextField(_ textField: UITextField) {
        if addJobTextField.text?.isEmpty == false && companyTextField.text?.isEmpty == false {
            self.navigationView.enableRightButton()
        }else {
            self.navigationView.disableRightButton()
        }
    }
}
// MARK: - UITextFieldDelegate

extension AddJobController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let count = textField.text?.count ?? 0
      
        if count <= 50 {
            
            if textField == addJobTextField {
                Service.countingOccupationWord(textField) { wordCount in
                    self.jobWordCountView.wordCountLabel.text = wordCount
                }
                
            }else {
                Service.countingOccupationWord(textField) { wordCount in
                    self.companyWordCountView.wordCountLabel.text = wordCount
                }
            }
            
        }else {
            
            self.alertMessage("You have reached word maximum",
                              answerButton: "Dismiss")
        }
    }
}
extension AddJobController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
       
        guard let job = addJobTextField.text else {return}
        guard let field = companyTextField.text else {return}
        
        let data:[String:Any] = ["profession": job,
                                 "company": field]
        
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addJobController(self, user: user)
            self.dismiss(animated: true)
        }
      
        
        
    }
    
    
}
