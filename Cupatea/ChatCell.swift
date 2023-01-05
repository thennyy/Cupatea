//
//  ChatCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/7/22.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    static let identifier = "chatcell"
    
    var message: Message? {
        didSet{ configure() }
    }
   
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!

    var timeStampLeftAnchor: NSLayoutConstraint!
    var timeStampRightAnchor: NSLayoutConstraint!
    
    var emojiLefContainerAnchor: NSLayoutConstraint!
    var emojiRightContainerAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    private let emojiImageView: UIImageView = {
       
        let iv = UIImageView()
     //   iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let timeStampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .accentColor
        
        return view
    }()
    private let messageTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 6
        tv.textColor = .white
        tv.isEditable = false
        tv.backgroundColor = .clear
        return tv
    }()
    private let messageBubbleRightImage: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "BubbleTailRight")?.withTintColor(.accentColor)
        iv.image = image
        return iv
    }()
    private lazy var messageBubbleLeftImage: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "BubbleTailLeft")?.withTintColor(.defaultGray)
        iv.image = image
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,
                                bottom: bottomAnchor,
                                paddingLeft: 8,
                                paddingBottom: 3)
        
        profileImageView.setDemensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(messageBubbleLeftImage)
        messageBubbleLeftImage.setDemensions(height: 30, width: 30)
        messageBubbleLeftImage.anchor(left: profileImageView.rightAnchor,
                                      bottom: profileImageView.bottomAnchor,
                                      paddingLeft: 3,
                                      paddingBottom: 3)
        
        addSubview(messageBubbleRightImage)
        messageBubbleRightImage.setDemensions(height: 30, width: 30)
        messageBubbleRightImage.anchor(bottom: profileImageView.bottomAnchor,
                                       right: rightAnchor,
                                       paddingBottom: 3,
                                       paddingRight: 18)
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 20
        bubbleContainer.clipsToBounds = true
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15)
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor.isActive = false
        
        messageBubbleRightImage.isHidden = true
        messageBubbleLeftImage.isHidden = true
        
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 333).isActive = true

        bubbleContainer.addSubview(messageTextView)
        messageTextView.anchor(top: bubbleContainer.topAnchor,
                               left: bubbleContainer.leftAnchor,
                               bottom: bubbleContainer.bottomAnchor,
                               right: bubbleContainer.rightAnchor,
                               paddingTop: 4,
                               paddingLeft: 9,
                               paddingBottom: 4,
                               paddingRight: 9)
        
        addSubview(emojiImageView)
        emojiImageView.setDemensions(height: 60, width: 60)
    
        emojiImageView.anchor(bottom: bottomAnchor, paddingBottom: -3)
        
        
        emojiLefContainerAnchor = emojiImageView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15)
        
        emojiRightContainerAnchor = emojiImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        
        emojiLefContainerAnchor.isActive = false
        emojiRightContainerAnchor.isActive = false
        
        emojiImageView.isHidden = true
        
        addSubview(timeStampLabel)
        timeStampLabel.anchor(top: messageTextView.bottomAnchor, paddingTop: 9)
        
        timeStampLeftAnchor = timeStampLabel.leftAnchor.constraint(equalTo: messageTextView.leftAnchor)
        
        timeStampRightAnchor = timeStampLabel.rightAnchor.constraint(equalTo: messageTextView.rightAnchor)
        
        timeStampLeftAnchor.isActive = false
        timeStampRightAnchor.isActive = false
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        guard let message = message else {return}
        let viewModel = MessageViewModel(message: message)

        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        messageTextView.textColor = viewModel.messageTextColor
        messageTextView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        timeStampLabel.text = viewModel.timeStamp
        
        messageBubbleLeftImage.isHidden = viewModel.hideMessageLeftTail
        messageBubbleRightImage.isHidden = viewModel.hideMessageRightTail
        
        emojiLefContainerAnchor.isActive = viewModel.emojiLeftAnchor
        emojiRightContainerAnchor.isActive = viewModel.emojiRightAnchor
        
        emojiImageView.isHidden = viewModel.shouldDisplayEmoji
        
        
        emojiImageView.image = UIImage(named: "\(message.emojiText)")
      //  print("DEBUG: EMOJI IMAGE IS \(message.emojiText)")
        bubbleContainer.isHidden = viewModel.shouldHideMessageBubble
        
        timeStampLeftAnchor.isActive = viewModel.timeStampOnTheLeft
        timeStampRightAnchor.isActive = viewModel.timeStampOnTheRight
        
        
    }
}
