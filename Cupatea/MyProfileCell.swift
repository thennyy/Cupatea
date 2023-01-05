//
//  MyProfileCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/21/22.
//

import UIKit

class MyProfileCell: UITableViewCell {
    
    static let identifier = "MyProfileCell"
    
    // MARK: - Properties
    
    var images: String! {
        didSet{
            iconImageView.image = UIImage(systemName: images)
           
        }
    }
    var viewModel: MyProfileViewModel! {
        didSet {
            configure()
        }
    }

     let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .gray
        label.text = "Title"
        
        return label
    }()
     let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "description"
        
        return label
    }()
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .accentColor
        return iv
    }()
    private let rightArrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .accentColor
        iv.image = UIImage(systemName: "chevron.right")
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        iconImageView.setDemensions(height: 27, width: 27)
        
        iconImageView.centerY(inView: self,
                              leftAnchor: leftAnchor,
                              paddingLeft: 21)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self, leftAnchor: iconImageView.rightAnchor,
                           paddingLeft: 30)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor,
                                left: iconImageView.rightAnchor,
                                right: rightAnchor,
                                paddingTop: 6,
                                paddingLeft: 30)
        
        addSubview(rightArrowImageView)
        rightArrowImageView.setDemensions(height: 13, width: 13)
        rightArrowImageView.centerY(inView: self,
                                    rightAnchor: rightAnchor,
                                    paddingRight: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
     //   descriptionLabel.isHidden = viewModel.isDisplayDescription
       // titleLabel.text = viewModel.title
    }
}
