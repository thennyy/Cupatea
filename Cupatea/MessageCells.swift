//
//  MessageCells.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/1/22.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "messageCellId"
    
    var conversation: Conversation! {
        didSet {
            configure()
        }
    }
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    private let timeStampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = 15
        clipsToBounds = true 
     //   backgroundColor = .shareColor
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,
                                 leftAnchor: leftAnchor,
                                 paddingLeft: 12)
        
        profileImageView.setDemensions(height: 51, width: 51)
        profileImageView.layer.cornerRadius = 51/2
        
        addSubview(usernameLabel)

        usernameLabel.anchor(top: profileImageView.topAnchor,
                             left: profileImageView.rightAnchor,
                             paddingTop: 6,
                             paddingLeft: 15)
        
        addSubview(messageTextLabel)
        messageTextLabel.anchor(top: usernameLabel.bottomAnchor,
                                left: usernameLabel.leftAnchor,
                                right: rightAnchor,
                                paddingTop: 9,
                                paddingRight: 9)
        
        addSubview(timeStampLabel)
        timeStampLabel.anchor(top: usernameLabel.topAnchor,
                              right: rightAnchor,
                              paddingRight: 20)
        
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        
        addSubview(lineView)
        lineView.anchor(left: profileImageView.rightAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor,
                        height: 0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        guard let conversation = conversation else {return}
        let viewModel = ConversationViewModel(conversation: conversation)
        usernameLabel.text = conversation.user.name
        messageTextLabel.text = viewModel.displayEmojiMessage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        timeStampLabel.text = viewModel.timestamp
        
    }
    
}
