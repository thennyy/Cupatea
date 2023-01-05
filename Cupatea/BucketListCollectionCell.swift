//
//  BucketListCollectionCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/25/22.
//

import UIKit

class BucketListTableCell: UITableViewCell {
    
    static let identifier = "BucketListCell"
    
    var index = 0
    let backGroundView = UIView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            
            textView.text = viewModel.bucketList
            
        }
    }
    
    private let textView = CustomTextView()
    
    private let contentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.titleMedium
        label.text = "Finished reading Harry Potter movies"
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "My Bucketlist"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])

        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0, length: attribute.length - 1))
        
        label.attributedText = attribute
        
        
        return label
    }()
    private let secondTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.text = "Something I always want to do..."

        return label
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        backgroundColor = .white

        textView.isEditable = false
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20)
        
        contentView.addSubview(secondTitle)
        secondTitle.anchor(top: titleLabel.bottomAnchor,
                           left: contentView.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 20)
     
        contentView.addSubview(textView)
        textView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 100,
                        paddingLeft: 20,
                        paddingRight: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
