//
//  DisplayEmojiCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/15/22.
//

import UIKit

class DisplayEmojiCell: UICollectionViewCell {
    
    static let identifier = "displayEmojiCell"
    
    var emojiLefContainerAnchor: NSLayoutConstraint!
    var emojiRightContainerAnchor: NSLayoutConstraint!
    
    private let emojiImageView: UIImageView = {
       
        let iv = UIImageView()
     //   iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
        
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,
                                bottom: bottomAnchor,
                                paddingLeft: 8,
                                paddingBottom: 3)
        
        profileImageView.setDemensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(emojiImageView)
        emojiImageView.setDemensions(height: 90, width: 90)
        emojiImageView.anchor(top: topAnchor, bottom: bottomAnchor)
        
        emojiLefContainerAnchor = emojiImageView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15)
        
        emojiRightContainerAnchor = emojiImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        
        emojiLefContainerAnchor.isActive = false
        emojiRightContainerAnchor.isActive = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
