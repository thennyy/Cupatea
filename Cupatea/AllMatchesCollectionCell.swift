//
//  AllMatchesCollectionCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

class AllMatchesCollectionCell: UICollectionViewCell {
    
    static let identifier = "AllMatchesCell"
   
    var viewModel: MatchCellViewModel! {
        didSet {
            
            userInfoLabel.text = viewModel.userInfo
            profileImageView.sd_setImage(with: viewModel.profileImageURL)

        }
    }
 
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.xmarkImage, for: .normal)
        button.tintColor = .gray
        button.setDemensions(height: 18, width: 18)
        return button
    }()
    private let giftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "giftLogo")?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
      //  button.tintColor = .accentColor
        button.setDemensions(height: 30, width: 30)
        return button
    }()
    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.chatImage, for: .normal)
        button.tintColor = .accentColor
        button.setDemensions(height: 30, width: 30)
        return button
    }()
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
       // iv.backgroundColor = .lightGray
        iv.setDemensions(height: 90, width: 90)
        iv.layer.cornerRadius = 90/2
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .smallMedium
        label.textColor = .black
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center 
        label.text = "Acton, MA"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .grayColor
        layer.cornerRadius = 15
        
        contentView.addSubview(profileImageView)
        profileImageView.centerX(inView: self,
                                 topAnchor: topAnchor,
                                 paddingTop: 20)
        
        
        let stackView = UIStackView(arrangedSubviews: [userInfoLabel,
                                                       locationLabel]).withAttributes(axis: .vertical, distribution: .fill)
        
        contentView.addSubview(stackView)
        stackView.centerX(inView: self,
                          topAnchor: profileImageView.bottomAnchor,
                          paddingTop: 20)
        
        
        let messageStackView = UIStackView(arrangedSubviews: [giftButton,
                                                              chatButton]).withAttributes(axis: .horizontal, spacing: 20, distribution: .fill)
//
//        contentView.addSubview(messageStackView)
//        messageStackView.centerX(inView: self,
//                                 topAnchor: stackView.bottomAnchor,
//                                 paddingTop: 20)
        
        contentView.addSubview(cancelButton)
        cancelButton.anchor(top: topAnchor,
                            right: rightAnchor,
                            paddingTop: 12,
                            paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData() {
        
    }
}
