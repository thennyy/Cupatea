//
//  MyAccountCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/23/22.
//

import UIKit
/*
enum MyAccountSections: Int, CaseIterable {
    case location
    case name
    case email
    case phone
    case password
    case age
    case starSign
    
    var description: String {
        switch self {
        case .location:
            return "Location"
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .phone:
            return "Phone"
        case .password:
            return "Password"
        case .age:
            return "Age"
        case .starSign:
            return "Star sign"
        }
        
    }
    
}
class MyAccountCell: UITableViewCell {
    
    static let identifier = "MyAccountCell"
    
    var viewModel: MyAccountViewModel! {
        didSet {
            configure()
            
        }
    }
    
    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        label.numberOfLines = 0
        
        label.anchor(top: topAnchor,
                     left: leftAnchor,
                     right: rightAnchor, paddingTop: 9, paddingLeft: 30)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        
        label.text = viewModel.value 
    }
}
*/
