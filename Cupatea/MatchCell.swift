//
//  MatchCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/21/22.
//

import UIKit

class MatchCell: UICollectionViewCell {
   
    static let identifier = "matchedCellId"
    
    var viewModel: MatchCellViewModel! {
        didSet{
            usernameLabel.text = viewModel.nameText
            matchedUserImageView.sd_setImage(with: viewModel.profileImageURL)
        }
    }
    private let matchedUserImageView: UIImageView = {

        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.accentColor.cgColor
        iv.setDemensions(height: 60, width: 60)
        iv.layer.cornerRadius = 60/2 
        return iv
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(matchedUserImageView)
        matchedUserImageView.centerY(inView: contentView)
//
//        let stack = UIStackView(arrangedSubviews: [matchedUserImageView])
//        stack.axis = .vertical
//        stack.distribution = .fillProportionally
//        stack.alignment = .center
//        stack.spacing = 6
//        addSubview(stack)
//        stack.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
