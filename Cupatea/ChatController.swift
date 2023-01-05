//
//  ChatController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/7/22.
//

import UIKit

enum setCollectionViewOriginHeight {
    case orginalHeight
    case resetHeight

}
protocol ChatControllerDelegate: AnyObject {
    func chatController(_ controller: ChatController)
    
}
class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let toUser: User
    private let currentUser: User
    private var messages = [Message]()
    private var fromCurrentUser = false
    private var keyboardHeight: CGFloat = 0
    private var bottomCollectionAnchor: CGFloat = 95
    
    private var isViewingEmoji = false
    
    weak var delegate: ChatControllerDelegate?
    
    private var chatNavigationView = ChatNavigationView()
    
    private lazy var messageCustomView : CustomMessageView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        let messageView = CustomMessageView(frame: frame)
        messageView.delegate = self
        return messageView
    }()

    
    private lazy var emojiView: CustomEmojiView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                           height: self.view.frame.height/2)
        let view = CustomEmojiView(frame: frame)
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    
    lazy var messageStackView: UIStackView = {
        
        messageCustomView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        
        emojiView.setDemensions(height: 400, width: view.frame.width)
        let stackView = UIStackView(arrangedSubviews: [messageCustomView, emojiView])
        emojiView.isHidden = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 9
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    init(toUser: User, currentUser: User) {
        self.toUser = toUser
        self.currentUser = currentUser
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchMessages()
      //  showLoader(true, withText: "Loading")
      //  self.adjustingCollectionView()
       
    }
    override var inputAccessoryView: UIView? {
        return messageCustomView
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true 
    }

    // MARK: - API

    func fetchMessages() {
        Service.fetchMessage(forUser: toUser) { [self] messages in
            self.messages = messages
            self.collectionView.reloadData()
            self.showLoader(false)
            self.adjustingCollectionView()
           
        }
    }
    
    // MARK: - Helpers
    
    func adjustingCollectionView() {
      
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
            self.collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 30, right: 0)
            self.collectionView.frame.origin.y = -30
        }, completion: nil)
      
    }
    private func configureUI() {
      
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        chatNavigationView.viewModel = ProfileViewModel(user: self.toUser)
        chatNavigationView.delegate = self
        
        view.addSubview(chatNavigationView)
        chatNavigationView.anchor(top: view.topAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  height: 120)

        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        collectionView.register(DisplayEmojiCell.self, forCellWithReuseIdentifier: DisplayEmojiCell.identifier)
        
        collectionView.keyboardDismissMode = .interactive
        collectionView.backgroundColor = .white
        emojiView.backgroundColor = .lightAcentColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(keyboardNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

       
    }
    


    // MARK: - Selectors
    
    private func removeEmojiView() {
        
        self.emojiView.isHidden = true
        self.collectionView.frame.origin.y = 0
        
        self.emojiView.removeFromSuperview()
     //   self.adjustingCollectionView()
        
    }
    @objc
    private func handleRightNavigationButton() {
        print("DEBUG: RIGHT button navigation")
    }
    
    @objc
    private func handleCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Managing keyboard
    @objc
    private func keyboardWillShow(keyboardNotification notification: Notification) {
        if self.view.frame.origin.y == 0 {
            if let userInfo = notification.userInfo {
                if let keyboardHeight = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardHeight.height
                    self.adjustingCollectionView()
                }
            }
           
        }
    }
    
    @objc
    private func keyboardWillHide() {
        
        if self.collectionView.frame.origin.y != 0 {
            print("DEBUG: REMOVING KEYBOARD ")
            if isViewingEmoji == false {
                self.view.frame.origin.y = 0
                self.collectionView.frame.origin.y = 30
            }else {
                self.collectionView.frame.origin.y -= self.view.frame.height/2
            }
           // self.messageCustomView.configureRemoveKeyboard()
            
        }
    }
    
}

    // MARK: - UICollectionViewDataSource

extension ChatController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
            cell.message = messages[indexPath.row]
            cell.message?.user = self.toUser
            
            return cell
            
    }
}

// MARK: - UICollectionViewDelegate

extension ChatController: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimateSizeCell = ChatCell(frame: frame)
        estimateSizeCell.message = messages[indexPath.row]
        estimateSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
        
        if messages[indexPath.row].isEmoji {
        
            return CGSize(width: view.frame.width, height: 90)
            
        }else {
        
            return .init(width: view.frame.width, height: estimatedSize.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45
    }

}

    // MARK: - CustomEmojiViewDelegate

extension ChatController: CustomEmojiViewDelegate {
    
    func customEmojiView(_ wantsToHideView: CustomEmojiView) {
        
        UIView.animate(withDuration: 0.2, delay: 0.1,
                       options: .curveEaseIn,
                       animations: {

            self.removeEmojiView()
            
            self.messageCustomView.configureEmojiButton()
            
        }, completion: nil)
    }
    
    func customEmojiView(_ view: CustomEmojiView, wantsToSendEmojiIndex indexPath: Int) {
        
        Service.uploadMessage("", to: toUser, sentEmoji: true, emojiIcon: "emoji\(indexPath)") { error in
            if let error = error {
                
                print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
                return
            }

            
        }
    }
 
}

    // MARK: - CustomMessageViewDelegate

extension ChatController: CustomMessageViewDelegate {
    func customMessageView(_ resettingCustomView: CustomMessageView) {
        self.adjustingCollectionView()
    }

  
    func customMessageView(_ customMessageview: CustomMessageView, button emojiButton: UIButton) {
        
        print("DEBUG: SELECTING THE EMOJI BUTTON ***********")
        isViewingEmoji = true 
        customMessageview.configureRemoveKeyboard()
        
        view.addSubview(emojiView)
        emojiView.anchor( left: view.leftAnchor, bottom: collectionView.bottomAnchor, right: view.rightAnchor, height:  300)
        
        self.collectionView.frame.origin.y -= self.view.frame.height/2
        
    }
    
    func customMessageView(_ customMessageView: CustomMessageView, wantsToSend message: String) {
        print("DEBUG: WANTS TO SEND MESSAGE ", toUser.name)
        Service.uploadMessage(message, to: toUser, sentEmoji: false, emojiIcon: "") { error in
            if let error = error {
                print("DEBUG: ERROR TO UPLOAD MESSAGE \(error.localizedDescription)")
                return
            }

            customMessageView.clearMessageText()
        }
    }
    
 
}
// MARK: - ChatNavigationViewDelegate
extension ChatController: ChatNavigationViewDelegate {
    func chatNavigationView(_ view: ChatNavigationView, backButton: UIButton) {
       navigationController?.popViewController(animated: true)

    }
    
    func chatNavigationView(_ view: ChatNavigationView, moreButton: UIButton) {
        print("DEBUG: more button pressed")
    }

    
}
