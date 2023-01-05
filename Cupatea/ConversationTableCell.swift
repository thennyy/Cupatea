//
//  ConversationTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/7/22.
//

import UIKit

class ConvosationTableCell: UITableViewCell {
    
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Thor"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor,
                                 paddingLeft: 12)
        profileImageView.setDemensions(height: 51, width: 51)
        profileImageView.layer.cornerRadius = 51/2
        
        addSubview(usernameLabel)
        usernameLabel.centerY(inView: profileImageView,
                              leftAnchor: profileImageView.rightAnchor,
                              paddingLeft: 9)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
