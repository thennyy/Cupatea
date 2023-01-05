//
//  PinFooterView.swift
//  EnterAct-Dating
//
//  Created by Thenny Chhorn on 10/17/21.
//

import UIKit

protocol BottomViewDelegate: AnyObject {
    func handleLike()
    func handleDislike()
    func handlePin()
}
/*
class BottomViewTemplate: UIView {
    
    let button = UIButton(type: .system)
    
    convenience init(image: String, imageColor: UIColor = .black, size: CGFloat, backGroundColor: UIColor = .accentColor){
        self.init()
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)?.withTintColor(imageColor)
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.anchor(width: size, height: size)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        layer.cornerRadius = 60/2
        layer.masksToBounds = true
        self.backgroundColor = backGroundColor
        addSubview(button)
       button.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}*/

class BottomControlView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: BottomViewDelegate?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.xmarkImage, for: .normal)
        button.backgroundColor = .shareColor
        button.layer.cornerRadius = 30
        button.tintColor = .systemRed
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        return button
    }()
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.pinFillImage, for: .normal)
        button.backgroundColor = .shareColor
        button.tintColor = .accentColor
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.heartFillImage, for: .normal)
        button.backgroundColor = .shareColor
        button.tintColor = .pinkColor
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        return button
    }()
  

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton,
                                                       pinButton,
                                                       likeButton])
        stackView.axis = .horizontal
        stackView.spacing = 21
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(pinButton)
        pinButton.setDemensions(height: 60, width: 60)
        pinButton.centerX(inView: self)
        
        addSubview(likeButton)
        likeButton.setDemensions(height: 60, width: 60)
        likeButton.centerY(inView: pinButton, leftAnchor: pinButton.rightAnchor, paddingLeft: 30)
        
        addSubview(cancelButton)
        cancelButton.setDemensions(height: 60, width: 60)
        cancelButton.centerY(inView: pinButton, rightAnchor: pinButton.leftAnchor, paddingRight: 30)
        
        cancelButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        pinButton.addTarget(self, action: #selector(handlePin), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func handleLike() {
        print("debug: HANDLE LIKE BUTTON")
        delegate?.handleLike()
    }
    @objc func handlePin() {
        print("debug: HANDLE PIN BUTTON")
        delegate?.handlePin()
    }
    @objc func handleDislike() {
        print("debug: HANDLE Dislike BUTTON")
        delegate?.handleDislike()
    }
}

