//
//  DisplayUserInfoView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/7/22.
//

import UIKit

class DisplayUserInfoView: UIView {
    
    private var viewModel: ProfileViewModel
    private var section: AboutMeSection
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
       // iv.image = .locationImage
        iv.tintColor = .black
        iv.setDemensions(height: 21, width: 21)
        return iv
        
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
        
    }()
    
    init(viewModel: ProfileViewModel, section: AboutMeSection) {
        self.viewModel = viewModel
        self.section = section 
        super.init(frame: .zero)
        
        configureData()
        
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel]).withAttributes(axis: .horizontal, spacing: 9, distribution: .fill)
        
        addSubview(stackView)
        stackView.fillSuperview()
        
      //  configureData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData() {
       
        switch section {
        case .job:
            break
        case .eduction:
            textLabel.text = viewModel.education
            imageView.image = .schoolImage
        case .myBio:
            break
        }
       
    }
}
