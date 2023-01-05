//
//  GenderView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/31/21.
//

import UIKit

class GenderView: UIView {
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .medium, size: 18)
        label.textColor = .white
        return label
    }()
    private lazy var checkedButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "checked")?.withTintColor(.white)
        button.setImage(image, for: .normal)
        return button
    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
    convenience init(selectedColor: UIColor = .white) {
        self.init()
        
        layer.cornerRadius = 9
        layer.borderWidth = 1
        layer.borderColor = selectedColor.cgColor
        
        backgroundColor = .accentColor
        addSubview(label)
        label.anchor(left: leftAnchor, paddingLeft: 30)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(checkedButton)
        checkedButton.anchor(right: rightAnchor, paddingRight: 15, width: 24, height: 24)
        checkedButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}

