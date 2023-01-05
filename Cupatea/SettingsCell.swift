//
//  SettingCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/25/21.
//

import UIKit
protocol SettingCellDelegate: AnyObject {
    func settingsCell(_ cell: SettingsCell,
                      wantsToUpdateUserWith value: String,
                      for section: SettingsSections)
}

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    weak var delegate: SettingCellDelegate?
    
    var viewModel: SettingsViewModel! {
        didSet { configure()}
    }
    lazy var inputTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Enter value here..."
        tf.borderStyle = .none
        tf.font = UIFont(name: .regular, size: 18)
        let paddingView = UIView()
        paddingView.setDemensions(height: 50, width: 27)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(handleUpdateUserInfo),
                     for: .editingDidEnd)
        return tf
        
    }()
    lazy var inputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: .regular, size: 18)
        tv.isScrollEnabled = false 
        return tv
    }()
    let placeholderLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        return button
    }()
    
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    var sliderStack = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        selectionStyle = .none
        contentView.addSubview(inputTextField)
        inputTextField.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor)
                             
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel, maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 15
        
        contentView.addSubview(sliderStack)

        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor,
                           right: rightAnchor,
                           paddingLeft: 24,
                           paddingRight: 24)
        
        contentView.addSubview(deleteButton)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
  
    @objc func handleAgeRangeChanged(sender: UISlider) {
        if sender == minAgeSlider {
            minAgeLabel.text = viewModel.minAgeLabelText(forValue: sender.value)
        }else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: sender.value)
        }
    }
    @objc func handleUpdateUserInfo() {
        guard let userInfo = inputTextField.text else {return}
        delegate?.settingsCell(self, wantsToUpdateUserWith: userInfo, for: viewModel.section)
    }
    
    // MARK: - Helpers
    
    func configure() {
        
        inputTextField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
       // inputTextField.placeholder = viewModel.placeholderText
        inputTextField.text = viewModel.value
        
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
        
        
    }
    
    func createAgeRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 80
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        
        return slider
    }
    
}
