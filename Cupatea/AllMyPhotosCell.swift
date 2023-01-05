//
//  AllMyPhotosCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/23/22.
//

import UIKit

class AllMyPhotosCell: UITableViewCell {
    
    static let identifier = "allMyPhotosCell"
  
    var user: User? {
        didSet {
        }
    }
    var imageURL: String! {
        didSet { userImageView.sd_setImage(with: URL(string: imageURL))}
    }
    
    var userImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
    
        return iv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      //  backgroundColor = .purple
        
        addSubview(userImageView)
        userImageView.fillSuperview()
        userImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


