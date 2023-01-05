//
//  ChatNavigationView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/17/22.
//

import UIKit
import SDWebImage

protocol ChatNavigationViewDelegate: AnyObject {
    func chatNavigationView(_ view: ChatNavigationView, backButton: UIButton)
    func chatNavigationView(_ view: ChatNavigationView, moreButton: UIButton)
    
}
class ChatNavigationView: UIView {
    
    weak var delegate: ChatNavigationViewDelegate?
    
    var viewModel: ProfileViewModel! {
        didSet {
            configureData()
        }
    }
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accentColor
        label.font = .regularBold
        label.textAlignment = .center
        return label
        
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(.backImage, for: .normal)
        button.tintColor = .black
        button.setDemensions(height: 36, width: 36)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(.moreImage, for: .normal)
        button.tintColor = .black
        button.setDemensions(height: 36, width: 36)
        button.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        return button
    }()
    private lazy var userProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.accentColor.cgColor
        button.setDemensions(height: 45, width: 45)
        button.layer.cornerRadius = 45/2
        button.clipsToBounds = true
        
        return button
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white 
        addSubview(leftButton)
      
        leftButton.anchor(left: leftAnchor,
                          bottom: bottomAnchor,
                          paddingLeft: 20,
                          paddingBottom: 20)
        
        addSubview(userProfileButton)
        userProfileButton.centerY(inView: leftButton,
                                  leftAnchor: leftButton.rightAnchor,
                                  paddingLeft: 6)
        
        addSubview(usernameLabel)
        usernameLabel.centerY(inView: userProfileButton,
                              leftAnchor: userProfileButton.rightAnchor,
                              paddingLeft: 15)
        
        addSubview(rightButton)
        rightButton.centerY(inView: leftButton,
                            rightAnchor: rightAnchor,
                            paddingRight: 20)
        
        let viewBar = UIView()
        viewBar.setDemensions(height: 1, width: frame.width)
        viewBar.backgroundColor = .shareColor
 
        addSubview(viewBar)
        viewBar.anchor(left: leftAnchor,
                       bottom: bottomAnchor,
                       right: rightAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureData() {
        Service.loadImage(with: viewModel.imageURLs[0]) { image in
            let image = image.withRenderingMode(.alwaysOriginal)
            self.userProfileButton.setImage(image, for: .normal)
        }
        usernameLabel.text = viewModel.username
    }
    @objc func handleBackButton(_ sender: UIButton) {
        delegate?.chatNavigationView(self, backButton: sender)
    }
    @objc func handleRightButton(_ sender: UIButton) {
        delegate?.chatNavigationView(self, moreButton: sender)
    }
}
