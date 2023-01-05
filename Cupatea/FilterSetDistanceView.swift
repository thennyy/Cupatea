//
//  FilterSetDistanceView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

class FilterSetDistanceView: UIView {
    
    private let titleLabel = UILabel()
    
    private  lazy var distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .accentColor
        slider.thumbTintColor = .accentColor
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .grayColor
        layer.cornerRadius = 15
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, distanceSlider])
        stackView.spacing = 24
        addSubview(stackView)

        stackView.centerY(inView: self)
        stackView.anchor(left: leftAnchor,
                           right: rightAnchor,
                           paddingLeft: 24,
                           paddingRight: 24)
        
        titleLabel.text = "\(Int(distanceSlider.value))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleAgeRangeChanged(sender: UISlider) {
      
        titleLabel.text = "\(Int(distanceSlider.value))"
      
    }
    
    
}
