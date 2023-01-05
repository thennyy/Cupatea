//
//  ProfileCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/29/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    static let identifier = "ProfileCell"
    
    let imageView = UIImageView()
    var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        imageView.fillSuperview()

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
