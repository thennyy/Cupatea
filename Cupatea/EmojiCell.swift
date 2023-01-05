//
//  EmojiCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/13/22.
//

import UIKit

protocol EmojiCellProtocol {
    func EmojiCell(_ collectionViewCell: EmojiCell)
}
class EmojiCell: UICollectionViewCell {
    
    static var identifier = "emojiCell"
    
//    var delegate: EmojiCellProtocol?
    
    lazy var emojiImageView: UIImageView = {
        
        let iv = UIImageView()
    
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTapEmojiImage))
        return iv
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentView.addSubview(emojiImageView)
        emojiImageView.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              bottom: contentView.bottomAnchor,
                              right: contentView.rightAnchor,
                              paddingTop: 3,
                              paddingLeft: 3,
                              paddingBottom: 3,
                              paddingRight: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleTapEmojiImage() {
        print("DEBUG: TApping image ")
     //   delegate?.EmojiCell(self)
    }
}
