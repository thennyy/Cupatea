//
//  FilterSliderView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

protocol FilterSliderViewDelegate: AnyObject {
    func settingsCell(_ cell: SettingsCell,
                      wantsToUpdateUserWith value: String,
                      for section: SettingsSections)
}
class FilterSliderView: UIView {
    
    
    var viewModel: SettingsViewModel! {
        didSet { configure()}
    }
    
    var delegate:FilterSliderViewDelegate?
    
    // MARK: - Properties
    
    private let minAgeLabel = UILabel()
    private let maxAgeLabel = UILabel()
    
    private  lazy var minAgeSlider = createAgeRangeSlider()
    private  lazy var maxAgeSlider = createAgeRangeSlider()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .regularMedium
        label.text = "Looking to date"

        return label
    }()

    var sliderStack = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .grayColor
        layer.cornerRadius = 15
        
        minAgeLabel.text = "\(Int(minAgeSlider.value))"
        maxAgeLabel.text = "\(Int(maxAgeSlider.value))"
        
//        minAgeSlider.minimumTrackTintColor = .lightGray
//        minAgeSlider.maximumTrackTintColor = .accentColor
//        
//        maxAgeSlider.minimumTrackTintColor = .accentColor
//        maxAgeSlider.maximumTrackTintColor = .lightGray
        
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel, maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 15
        

        addSubview(sliderStack)

        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor,
                           right: rightAnchor,
                           paddingLeft: 24,
                           paddingRight: 24)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    @objc func handleAgeRangeChanged(sender: UISlider) {
       
        if sender == minAgeSlider {
            minAgeLabel.text = "\(Int(minAgeSlider.value))"
        }else {
            maxAgeLabel.text = "\(Int(maxAgeSlider.value))"
                    
        }
    }
    @objc func handleUpdateUserInfo() {
//        guard let userInfo = inputTextField.text else {return}
//        delegate?.settingsCell(self, wantsToUpdateUserWith: userInfo, for: viewModel.section)
    }
    func createAgeRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 99
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        slider.tintColor = .accentColor
        slider.thumbTintColor = .accentColor
        return slider
    }
    func configure() {
        
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
        
        
    }
}
