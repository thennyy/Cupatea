//
//  NavigationView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/14/22.
//

import UIKit
protocol NavigationViewDelegate: AnyObject {
    func navigationView(_ view: NavigationView, leftButton: UIButton)
    func navigationView(_ view: NavigationView, rightButton: UIButton)
}
class NavigationView: UIView {
    
    weak var delegate: NavigationViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accentColor
        label.font = .titleMedium
        label.textAlignment = .center
        return label
    }()
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
      // button.backgroundColor = .systemGroupedBackground
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(.filterImage, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.tintColor = .accentColor
        return button
    }()
 
    convenience init(title: String? = nil, leftButtonImage: UIImage? = .backImage, rightButtonImage: UIImage? = .none) {
        self.init()

        leftButton.setImage(leftButtonImage, for: .normal)
        rightButton.setImage(rightButtonImage, for: .normal)
        titleLabel.text = title
        
        addSubview(titleLabel)
       
        titleLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 30)
        
        
        addSubview(leftButton)
        leftButton.setDemensions(height: 36, width: 36)
        leftButton.centerY(inView: titleLabel,
                           leftAnchor: leftAnchor,
                           paddingLeft: 20)

        addSubview(rightButton)
        rightButton.setDemensions(height: 36, width: 36)
        rightButton.centerY(inView: titleLabel,
                            rightAnchor: rightAnchor,
                            paddingRight: 20)
        
        rightButton.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        
    }

    @objc func handleLeftButton(_ sender: UIButton) {
        delegate?.navigationView(self, leftButton: sender)
    }
    @objc func handleRightButton(_ sender: UIButton) {
        delegate?.navigationView(self, rightButton: sender)
    }
}
