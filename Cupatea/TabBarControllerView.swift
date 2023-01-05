//
//  TabBarControllerView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/12/22.
//

import UIKit
protocol TabBarControllerViewDelegate: AnyObject {
    func tabBarControllerView(_ view: TabBarControllerView, userButton: UIButton)
    func tabBarControllerView(_ view: TabBarControllerView, messageButton: UIButton)
}
class TabBarControllerView: UIView {
    
    weak var delegate: TabBarControllerViewDelegate!
    
    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.chatImage, for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleMessageButton),
                         for: .touchUpInside)
        return button
    }()
    private lazy var userButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.cup_tabBarImage, for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleUserButton),
                         for: .touchUpInside)
        return button
    }()
    private lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.exploreImage, for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.notificationImage, for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    lazy var stackView = UIStackView(arrangedSubviews: [exploreButton,
                                                        notificationButton,
                                                        chatButton]).withAttributes(axis: .horizontal, spacing: 30, distribution: .fillEqually)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 27
        layer.masksToBounds = true
        
       // userButton.setDemensions(height: 30, width: 30)
      //  backgroundColor = .shareColor
        addSubview(stackView)
        stackView.fillSuperview()
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleUserButton(_ sender: UIButton) {
        delegate.tabBarControllerView(self, userButton: sender)
    }
    @objc func handleMessageButton(_ sender: UIButton) {
        delegate.tabBarControllerView(self, messageButton: sender)
    }
}
