//
//  SpendExtraTimeCollectionCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/25/22.
//

import UIKit

class SpendExtraTimeTableView: UITableViewCell {
    
    static let identifier = "SpendExtraTimeCell"
    
    var index = 0
    let backGroundView = UIView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            
            textView.text = viewModel.extraTime 
            
        }
    }
    private let textView = CustomTextView()
    
    private let contentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.titleMedium
        return label
    }()
    private let secondTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.text = "Get to know more this person more..."

        //label.font = UIFont.regularBold
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Interested?"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])

        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0, length: attribute.length - 1))
        
        label.attributedText = attribute
        
        
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
        
        backGroundView.backgroundColor = .grayColor
        backGroundView.layer.cornerRadius = 20
         
        contentView.addSubview(secondTitle)
        secondTitle.anchor(top: titleLabel.bottomAnchor,
                              left: titleLabel.leftAnchor,
                              paddingTop: 6)
        
        contentView.addSubview(textView)
        textView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 100,
                        paddingLeft: 20,
                        paddingRight: 20)

     
//        addSubview(backGroundView)
//        backGroundView.anchor(top: secondTitle.bottomAnchor,
//                        left: leftAnchor,
//                        bottom: bottomAnchor,
//                        right: rightAnchor,
//                        paddingTop: 20,
//                        paddingLeft: 20,
//                        paddingRight: 20)
//
//        backGroundView.addSubview(contentTextLabel)
//        contentTextLabel.anchor(top: backGroundView.topAnchor,
//                                left: backGroundView.leftAnchor,
//                                bottom: backGroundView.bottomAnchor,
//                                right: backGroundView.rightAnchor,
//                                paddingTop: 20,
//                                paddingLeft: 20,
//                                paddingBottom: 20,
//                                paddingRight: 20)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
