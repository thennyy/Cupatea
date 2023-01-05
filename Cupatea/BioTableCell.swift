//
//  BioCollectionCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/25/22.
//

import UIKit


//class BioCollectionCell: UICollectionViewCell {
    
class BioTableCell: UITableViewCell {
    
    static let identifier = "BioTableCell"
    
    var index = 0
    let bioView = UIView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            
            bioTextView.text = viewModel.bio
            
        }
    }
    var bioTextView = CustomTextView()
    
    private let bioLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = .black
        label.font = UIFont.titleMedium
        return label
    }()
    private let bioTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Get to know me..."
        let font = UIFont.regularMedium
        
        let attribute = NSMutableAttributedString(string: label.text!)
                                        

        attribute.addAttribute(.kern, value: 3,
                               range: NSRange(location: 0, length: attribute.length - 1))
        
        label.attributedText = attribute
    
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Bio"
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
        bioTextView.isEditable = false
       
        bioView.backgroundColor = .grayColor
        bioView.layer.cornerRadius = 20
        
//        contentView.addSubview(bioView)
//        bioView.fillSuperview()
//        
//        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20,
                          height: 33)
        
        contentView.addSubview(bioTextView)
        bioTextView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 60,
                           paddingLeft: 20,
                           paddingRight: 20)


                
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
