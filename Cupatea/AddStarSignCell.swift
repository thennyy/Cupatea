//
//  AddStarSignTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/22.
//

import UIKit

class AddStarSignCell: UICollectionViewCell {
    
    static let identifier = "AddStarSigncell"
    
    let starSignImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDemensions(height: 24, width: 24)
      
        return iv
    }()
    let checkImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .checkImage?.withTintColor(.systemGreen)
        
        iv.contentMode = .scaleAspectFill
        iv.setDemensions(height: 21, width: 21)
        iv.isHidden = true
        return iv
    }()
    let starSignLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private let backGroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        layer.cornerRadius = 12
        
        configureSelectAnswer(color: .lightGray, height: 1)
        
        
        contentView.addSubview(starSignLabel)
        starSignLabel.centerX(inView: self)
        starSignLabel.centerY(inView: self)
        
        
        contentView.addSubview(starSignImageView)
        starSignImageView.centerY(inView: starSignLabel,
                                  rightAnchor: starSignLabel.leftAnchor,
                                  paddingRight: 9)

      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelectAnswer(color: UIColor, height: CGFloat) {
        self.layer.borderWidth = height
        self.layer.borderColor = color.cgColor
    }
  
}
