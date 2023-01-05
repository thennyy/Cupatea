//
//  File.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/5/22.
//

import UIKit

class AddSeekingCell: UICollectionViewCell {
    
    static let identifier = "AddSeekingCell"
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        //  label.font = .regularMedium
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.borderWidth = 1
       // layer.borderColor = UIColor.grayColor.cgColor
        
        layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(titleTextLabel)
        
        titleTextLabel.centerX(inView: self)
        titleTextLabel.centerY(inView: self)
        
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
}
