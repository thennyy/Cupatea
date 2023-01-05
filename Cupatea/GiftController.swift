//
//  GiftController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/25/22.
//

import UIKit

class GiftController: UICollectionViewController {
    
    private let emojiView = CustomEmojiView()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.xmarkCircleImage, for: .normal)
        button.setDemensions(height: 21, width: 21)
        button.tintColor = .darkGray
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    func configureUI() {
        
        view.backgroundColor = .white
      //  configureGradientLayer()

        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.topAnchor,
                            left: view.leftAnchor,
                            paddingTop: 9,
                            paddingLeft: 9)
        
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifier)
        cancelButton.addTarget(self, action: #selector(handleCancelButton),
                               for: .touchUpInside)
        
    }
    @objc func handleCancelButton() {
        self.dismiss(animated: true)
    }
    
}

extension GiftController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifier, for: indexPath) as! EmojiCell
        cell.emojiImageView.image = UIImage(named: "emoji\(indexPath.row)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // send emoji index to the database
      //  delegate?.customEmojiView(self, wantsToSendEmojiIndex: indexPath.row)
        print("DEBUG: USER DID SELECT THE EMOJI ==> \(indexPath.row)")
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 45, left: 20, bottom: 10, right: 20)
    }

    
    
}
