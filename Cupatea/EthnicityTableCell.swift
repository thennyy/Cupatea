//
//  EthnicityTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/3/22.
//

import UIKit

class EthnicityTableCell: UICollectionViewCell {
 
    static let identifier = "AddEthnicityCell"
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
      //  label.font = .regularMedium
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .white

        addSubview(titleTextLabel)
            
        titleTextLabel.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor, paddingTop: 6,
                              paddingLeft: 30, paddingBottom: 6,
                              paddingRight: 30)
                              
        
        titleTextLabel.layer.cornerRadius = 12
        titleTextLabel.layer.borderWidth = 1
        titleTextLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
