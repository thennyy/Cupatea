//
//  AddHeightController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit
protocol AddHeightControllerDelegate: AnyObject {
    func addHeightController(_ controllerWantsToUpdateEduction: AddHeightController, user: User)
}
class AddHeightController: UIViewController {

    // MARK: - Properties
    private var selectedAnswer: String? = nil
    var user: User!
    weak var delegate: AddHeightControllerDelegate?
    
    private let pickerData = ["3'7", "3'8", "3'9", "3'10", "3'10","3'11","4'0","4'1","4'2","4'3","4'4","4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1","5'2","5'3","5'4","5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11", "7'0","7'1","7'2","7'3"]
  
    private lazy var navigationView = AddSettingNavigationView(title: "Set Height",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Save",
                                                               delegate: self)
    
  
    private lazy var titleTextButton: UIButton = {
        let button = UIButton(type: .system)
       // button.setTitle("Done", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .regularMedium
        button.layer.borderColor = UIColor.accentColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 9
        button.setDemensions(height: 54, width: self.view.frame.width - 60)
        button.addTarget(self, action: #selector(handleTitleHeightButton),
                         for: .touchUpInside)
        return button
    }()

 
    private lazy var selectHeightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.tintColor = .accentColor
        button.addTarget(self, action: #selector(handleSelectButton),
                         for: .touchUpInside)
        button.backgroundColor = .grayColor
        button.titleLabel?.font = .regularMedium

        return button
    }()
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = .regularMedium
        button.backgroundColor = .grayColor
        button.addTarget(self, action: #selector(handleDismissButton),
                         for: .touchUpInside)
     //   button.contentHorizontalAlignment = .left
        return button
    }()
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .grayColor
        picker.delegate = self
        picker.dataSource = self
        picker.layer.borderWidth = 0.3
        picker.layer.borderColor = UIColor.lightGray.cgColor

        return picker
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHeightData()
        
    }
    
    lazy var buttonStackView = UIStackView(arrangedSubviews: [dismissButton, selectHeightButton]).withAttributes(axis: .horizontal,spacing: 3,distribution: .fillEqually)

    lazy var pickerStackView = UIStackView(arrangedSubviews: [buttonStackView, pickerView]).withAttributes(axis: .vertical, spacing: 3, distribution: .fill)

    // MARK: - Helpers
    func configureTitleTextButton(color: UIColor, height: CGFloat) {
        titleTextButton.layer.borderColor = color.cgColor
        titleTextButton.layer.borderWidth = height
    }
    func configureUI() {
        
        view.backgroundColor = .white
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)
        
        
        
        view.addSubview(titleTextButton)
        titleTextButton.centerX(inView: view,
                                topAnchor: navigationView.bottomAnchor,
                                paddingTop: 100)
        

        buttonStackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        pickerStackView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        view.addSubview(pickerStackView)
        pickerStackView.anchor(left: view.leftAnchor,
                               bottom: view.bottomAnchor,
                               right: view.rightAnchor)
        
  
        
    }
    
    func configureHeightData() {
        var count = 0
        for item in pickerData {
            if item == user.height {
                print("DEBUG: SELECTED ROW", count)
                self.pickerView.selectRow(count, inComponent: 0, animated: true)
                self.titleTextButton.setTitle(user.height, for: .normal)
                self.configureTitleTextButton(color: .accentColor, height: 3)
                
            }else if user.height.isEmpty == true {
     
                self.pickerView.selectRow(9, inComponent: 0, animated: true)
                self.titleTextButton.setTitle(self.pickerData[9], for: .normal)
            }
            count += 1
        }
        
    }
    // MARK: - Actions
    @objc func handleSelectButton(_ sender: UIButton) {
        titleTextButton.layer.borderColor = UIColor.lightGray.cgColor
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.pickerStackView.alpha = 0
            self.pickerStackView.layoutIfNeeded()
        }
    }
    @objc func handleTitleHeightButton(_ sender: UIButton) {
        configureTitleTextButton(color: .accentColor, height: 3)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.pickerStackView.alpha = 1
            self.pickerStackView.layoutIfNeeded()
            
        }
    }
    @objc func handleDismissButton(_ sender: UIButton) {
        configureTitleTextButton(color: .lightGray, height: 1)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.pickerStackView.alpha = 0
            self.pickerStackView.layoutIfNeeded()
        }
    }
}
// MARK: - AddSettingNavigationViewDelegate

extension AddHeightController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
        let data: [String:Any] = ["height": selectedAnswer ?? "" ]
        guard let user = self.user else {return}
    
        Service.updateUserPreference(userId: user.uid, data: data) { user in
            self.delegate?.addHeightController(self, user: user)
            self.dismiss(animated: true)
            
        }
    }

    
}
// MARK: - UIPickerViewDelegate

extension AddHeightController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return pickerData[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        titleTextButton.isEnabled = true
        configureTitleTextButton(color: .accentColor, height: 3)
        titleTextButton.setTitle(pickerData[row], for: .normal)
        selectedAnswer = pickerData[row]
        navigationView.enableRightButton()
        
        
    }
    
}
