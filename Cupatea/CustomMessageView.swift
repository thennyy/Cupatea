//
//  CustomMessageView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/16/22.
//

import UIKit

protocol CustomMessageViewDelegate {
    func customMessageView(_ resettingCustomView: CustomMessageView)
    func customMessageView(_ customMessageview: CustomMessageView, button emojiButton: UIButton)
    func customMessageView(_ customMessageView: CustomMessageView, wantsToSend message: String)
}
class CustomMessageView: UIView {
    
    // MARK: - Properties
    
    var delegate: CustomMessageViewDelegate?
    
    var heightConstraint: NSLayoutConstraint!
    var heightFor5Lines: CGFloat = 0
    
    var emojiHandler: CustomEmojiView?
    
    private lazy var messageInputTextView: UITextView = {
        
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.layer.cornerRadius = 12
        tv.backgroundColor = .clear
        tv.textColor = .black
       tv.delegate = self
        
        return tv
        
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setImage(.sendButtonImage, for: .normal)
        button.tintColor = .accentColor 
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.accentColor,
                             for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage),
                         for: .touchUpInside)
        return button
    }()
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        
        return label
    }()
    var inputTextView = UIView()
    
    private lazy var addGiftButton: UIButton = {
        let button = UIButton()
        let image =  UIImage.heartFillImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
    
        button.tintColor = .pinkColor
        button.addTarget(self, action: #selector(handleAddEmojiButton(sender:)), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor

     //   emojiHandler?.customMessageView = self
        
        addSubview(sendButton)
        sendButton.anchor(top:  topAnchor,
                          right: rightAnchor,
                          paddingTop: 4,
                          paddingRight: 15)
        
        sendButton.setDemensions(height: 50, width: 50)


        inputTextView.backgroundColor = .defaultGray
        inputTextView.layer.cornerRadius = 18
        
        inputTextView.addSubview(messageInputTextView)
        
        heightConstraint = messageInputTextView.heightAnchor.constraint(equalToConstant: 40)
        heightConstraint.isActive = true
        
        messageInputTextView.anchor(top: inputTextView.topAnchor,
                                    left: inputTextView.leftAnchor,
                                    bottom: inputTextView.bottomAnchor,
                                    right: inputTextView.rightAnchor,
                                    paddingTop: 0,
                                    paddingLeft: 6,
                                    paddingBottom: 0,
                                    paddingRight: 6)
      

        addSubview(inputTextView)
        inputTextView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: sendButton.leftAnchor,
                             paddingTop: 12,
                             paddingLeft: 12,
                             paddingBottom: 45,
                             paddingRight: 12)
        
   
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: messageInputTextView.topAnchor,
                                left: messageInputTextView.leftAnchor,
                                paddingTop: 9,
                                paddingLeft: 6)
        
//
//        addSubview(addGiftButton)
//        addGiftButton.setDemensions(height: 36, width: 36)
//        addGiftButton.centerY(inView: sendButton,
//                              rightAnchor: sendButton.leftAnchor,
//                              paddingRight: 6)
//
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)



        let lineView = UIView()
        lineView.backgroundColor = .shareColor
        
        addSubview(lineView)
        lineView.anchor(top: topAnchor,
                        left: leftAnchor,
                        right: rightAnchor,
                        height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return .zero
    }

    // MARK: - Selectors
    
    @objc func handleTextInputDidChange() {
        print("DEBUG: OBSERVING TEXTVIEW CONSTRAINTS ", messageInputTextView.frame.height)
        sendButton.isEnabled = !self.messageInputTextView.text.isEmpty
        placeHolderLabel.isHidden = !self.messageInputTextView.text.isEmpty
     
    }
    @objc func handleAddEmojiButton(sender: UIButton) {
        
        configureRemoveKeyboard()
        delegate?.customMessageView(self, button: sender)
        
    }
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else {return}
        delegate?.customMessageView(self, wantsToSend: message)
      //  configureEmojiButton()
    }
    
    
    // MARK: - Helpers
    
    func configureRemoveKeyboard() {
        messageInputTextView.resignFirstResponder()
    }
    func configureShowKeyboard() {
        messageInputTextView.becomeFirstResponder()
    }
    func clearMessageText() {
        messageInputTextView.text = nil
        placeHolderLabel.isHidden = false
        sendButton.isEnabled = false
    
        heightConstraint.constant = 40
       
    }
    func configureEmojiButton() {
        print("DEBUG: EMOJI BUTTON ")
        addGiftButton.isEnabled = !addGiftButton.isEnabled
    }
}

// MARK: - UITextViewDelegate

extension CustomMessageView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       // configureShowKeyboard()
        addGiftButton.isEnabled = true
      
        delegate?.customMessageView(self)
    }
    
    func textViewDidChange(_ textView: UITextView) {

        delegate?.customMessageView(self)
        
        
        let numberOfLines = textView.contentSize.height/(textView.font?.lineHeight)!

               if Int(numberOfLines) > 5 {
                   self.heightConstraint.constant = heightFor5Lines
               }else {
                   if Int(numberOfLines) == 5 {
                       self.heightFor5Lines = textView.contentSize.height
                   }
                   self.heightConstraint.constant = textView.contentSize.height
               }
            textView.layoutIfNeeded()
    }
        
}
extension CustomMessageView: ChatControllerDelegate {
    func chatController(_ controller: ChatController) {
        print("DEBUG: CHAT CONTROLLER ")
        addGiftButton.isEnabled = true
    }
    
}
