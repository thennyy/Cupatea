//
//  SettingHeader.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/25/21.
//

import UIKit
import SDWebImage
protocol SettingHeaderDelegate: AnyObject {
    
    func settingHeader(_ header: SettingHeader, select index: Int)
    func myProfileHeader(_ header: SettingHeader, select index: Int)
    func myProfileHeader(_ header: SettingHeader, user userInfo: User)
    func myProfileHeader(_ header: SettingHeader, user userInfo: User, dimissButton: UIButton)
}

class SettingHeader: UIView {
    
    //MARK: - Properties
    
    weak var delegate : SettingHeaderDelegate?
    var buttons = [UIButton]()
    
    private var user: User
 
    private let locationView = LocationView()
  //  private let profileCompletionView = ProfileCompletionView(text: "50% complete")
  //  private let verifyButton = VerifyUserButton()

  
    private lazy var deleteImageButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage.trashImage
        button.setTitle("Delete", for: .normal)
        button.tintColor = .darkGray
        button.setDemensions(height: 45, width: 150)
        return button
    }()
    
    private lazy var viewProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Preview", for: .normal)
        button.titleLabel?.font = UIFont.regularMedium
        button.tintColor = .gray
        button.addTarget(self, action: #selector(handleViewAllPhotos),
                         for: .touchUpInside)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        
        return button
    }()

    private lazy var activeLocationButton: SendMessageButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("Activate Location", for: .normal)
        button.titleLabel?.font = UIFont.regularMedium
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleActivateLocation),
                         for: .touchUpInside)
        return button
    }()

    lazy var button1 = createButton(0)
    lazy var button2 = createButton(1)
    lazy var button3 = createButton(2)
    lazy var button4 = createButton(3)
    lazy var button5 = createButton(4)
    lazy var button6 = createButton(5)
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)

        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        buttons.append(button5)
        buttons.append(button6)
        
//        addSubview(profileCompletionView)
//        profileCompletionView.anchor(top: topAnchor,
//                            left: leftAnchor,
//                            right: rightAnchor,
//                            paddingTop: 20,
//                            paddingLeft: 20,
//                            paddingRight: 20,
//                            height: 54)
//
//        addSubview(verifyButton)
//        verifyButton.anchor(top: profileCompletionView.bottomAnchor,
//                            left: profileCompletionView.leftAnchor,
//                            right: profileCompletionView.rightAnchor,
//                            paddingTop: 20,
//                            height: 54)
//
        
        addSubview(button1)
        button1.setDemensions(height: 250, width: 250)
        button1.anchor(top: topAnchor,
                       left: leftAnchor,
                       paddingTop: 50,
                       paddingLeft: 20)
        
        let stackView1 = UIStackView(arrangedSubviews: [button2, button3])
        stackView1.axis = .vertical
        stackView1.distribution = .fillEqually
        stackView1.spacing = 20
        
        addSubview(stackView1)
        let stackView2 = UIStackView(arrangedSubviews: [button4,
                                                        button5,
                                                        button6])
        
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.spacing = 20
 
        
        addSubview(stackView2)
        stackView2.anchor(top: button1.bottomAnchor,
                          left: button1.leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: 20, paddingBottom: 99,
                          paddingRight: 20)
                         
        addSubview(stackView1)
        stackView1.anchor(top: button1.topAnchor,
                          left: button1.rightAnchor,
                          bottom: stackView2.topAnchor,
                          right: rightAnchor,
                          paddingLeft: 20,
                          paddingBottom: 20,
                          paddingRight: 20)
        
        addSubview(viewProfileButton)
        viewProfileButton.setDemensions(height: 39, width: 200)
        viewProfileButton.layer.cornerRadius = 39/2
        viewProfileButton.centerX(inView: stackView2,
                                  topAnchor: stackView2.bottomAnchor,
                                  paddingTop: 30)
        
        loadUserPhotos()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    
    
    @objc
    private func handleSelectPhoto(sender: UIButton){
        delegate?.settingHeader(self, select: sender.tag)
    }
    
    @objc
    private func handleDeletePhoto(sender: UIButton) {
        delegate?.myProfileHeader(self, select: sender.tag)
    }
    
    @objc
    private func handleViewAllPhotos() {
        delegate?.myProfileHeader(self, user: user)
    }
    @objc
    private func handleActivateLocation(_ sender: UIButton) {
        delegate?.myProfileHeader(self, user: user, dimissButton: sender)
    }
    //MARK: - Helpers
    
    func loadUserPhotos() {
        let imageURLs = user.imageURLs.map({URL(string: $0)})
        for (index, url) in imageURLs.enumerated() {
            SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground,
                                               progress: nil) { image, _, _, _, _, _ in
                self.buttons[index].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
      
            }
            
        }
    }
    
    func createButton(_ index: Int) -> UIButton {
        
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "plus.square.dashed", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27))
        button.tintColor = .lightGray
        button.setImage(image, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleSelectPhoto(sender:)), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .shareColor
        button.tag = index
        button.imageView?.contentMode = .scaleAspectFill

        return button
    }
}
