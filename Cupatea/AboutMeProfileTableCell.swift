//
//  AboutMeProfileTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

class AboutMeProfileTableCell: UITableViewCell {
    
    static let identifier = "AboutMeprofileTableCell"
    
    var viewModel: ProfileViewModel! {
        didSet {
            configureData()
        }
    }
    var section: AboutMeSection!
    
    // MARK: - Properties
    
    
    private let workIconImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.setDemensions(height: 21, width: 21)
        return iv
        
    }()
    private let educationIconImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.setDemensions(height: 21, width: 21)
        return iv
        
    }()
    
    private let workTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
        
    }()
    private let educationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
        
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let workStackView = UIStackView(arrangedSubviews: [workIconImage, workTitleLabel]).withAttributes(axis: .horizontal, spacing: 9, distribution: .fill)
        let schoolStackView = UIStackView(arrangedSubviews: [educationIconImage, educationLabel]).withAttributes(axis: .horizontal, spacing: 9, distribution: .fill)
        
        let stackView = UIStackView(arrangedSubviews: [workStackView, schoolStackView]).withAttributes(axis: .vertical, spacing: 9, distribution: .fill)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         paddingTop: 9,
                         paddingLeft: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureData() {
        
        if viewModel.occupation.isEmpty == false {
            workTitleLabel.text = viewModel.occupation
            workIconImage.image = .professionImage
        }
        if viewModel.education.isEmpty == false {
            educationLabel.text = viewModel.education
            educationIconImage.image = .schoolImage
        }

    }
}
