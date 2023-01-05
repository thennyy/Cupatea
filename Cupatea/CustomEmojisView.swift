//
//  EmojisView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/9/22.
//

import UIKit

protocol CustomEmojiViewDelegate {
    func customEmojiView(_ wantsToHideView: CustomEmojiView)
    func customEmojiView(_ view: CustomEmojiView, wantsToSendEmojiIndex indexPath: Int)
}

class CustomEmojiView: UIView {
    
    // MARK: - Properties
    
    var delegate: CustomEmojiViewDelegate?
    
   // var customMessageView: CustomMessageView?
    
    private var images = [UIImage]()
    
    private lazy var hideEmojiIconButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.compact.down")
        button.setImage(image, for: .normal)
        button.tintColor = .accentColor
        button.addTarget(self, action: #selector(handleHideEmojiView), for: .touchUpInside)
        return button
    }()
 

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)

        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        
        cv.backgroundColor = .yellow
        return cv

    }()
    
 
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
      //  customMessageView?.emojiHandler = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .white
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor


        let lineView = UIView()
        lineView.backgroundColor = .shareColor
        
        addSubview(lineView)
        lineView.anchor(top: topAnchor,
                        left: leftAnchor,
                        right: rightAnchor,
                        height: 0.5)
        
        addSubview(hideEmojiIconButton)
        hideEmojiIconButton.anchor(top: topAnchor, paddingTop: 15)
        hideEmojiIconButton.centerXToSuperview()
        
        addSubview(collectionView)
        collectionView.anchor(top: hideEmojiIconButton.bottomAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 15,
                              paddingLeft: 15,
                              paddingBottom: 9,
                              paddingRight: 15)
        
        collectionView.register(EmojiCell.self,
                                forCellWithReuseIdentifier: EmojiCell.identifier)
        
    }
    @objc
    private func handleHideEmojiView() {
        delegate?.customEmojiView(self)
       // customMessageView?.configureEmojiButton()
    }
    
}


extension CustomEmojiView: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifier, for: indexPath) as! EmojiCell
        cell.emojiImageView.image = UIImage(named: "emoji\(indexPath.row)")
        
        return cell
    }
    
    
}
extension CustomEmojiView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // send emoji index to the database
        delegate?.customEmojiView(self, wantsToSendEmojiIndex: indexPath.row)
        print("DEBUG: USER DID SELECT THE EMOJI ==> \(indexPath.row)")
    }
}

