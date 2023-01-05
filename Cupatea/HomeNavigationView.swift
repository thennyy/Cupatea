//
//  ProfileNavigationView.swift
//  EnterAct_TEST
//
//  Created by Thenny Chhorn on 10/19/21.
//

import UIKit
protocol HomeNavigationViewDelegate: AnyObject {
    func showSettings()
    func showMatchingController()
}
class HomeNavigationView: UIView {
   
    weak var delegate: HomeNavigationViewDelegate?
 
    private let matchingButton = UIButton(image: "cup", color: .lightAcentColor)
    
    private let titleImage: UIImageView = {
    
        let image = UIImageView(image: UIImage(named:"title")?.withTintColor(.accentColor))
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
       // image.tintColor = .accentColor
        return image
    }()

    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
      // button.backgroundColor = .systemGroupedBackground
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(.filterImage, for: .normal)
        button.tintColor = .black
        return button
    }()
    lazy var userButton: KeepSwipingButton = {
        let button = KeepSwipingButton(type: .system)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.pinkColor.cgColor
        return button
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleImage)
        titleImage.clipsToBounds = true
        titleImage.anchor(top: topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingLeft: 51,
                          paddingRight: 51,
                          height: 60)
        
                           
        addSubview(userButton)
        userButton.setDemensions(height: 36, width: 36)
        userButton.centerY(inView: self,
                           leftAnchor: leftAnchor,
                           paddingLeft: 20)
        
        addSubview(matchingButton)
        matchingButton.setDemensions(height: 36, width: 36)
        matchingButton.centerY(inView: self,
                               rightAnchor: rightAnchor,
                               paddingRight: 20)
        
        userButton.addTarget(self, action: #selector(handleMyProfileButton),
                             for: .touchUpInside)

        matchingButton.addTarget(self, action: #selector(handleMatchingButton),
                                 for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleMyProfileButton() {
        delegate?.showSettings()
    }
    @objc func handleMatchingButton() {
        delegate?.showMatchingController()
    }
}
