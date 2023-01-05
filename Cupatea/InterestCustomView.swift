//
//  InterestCustomView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/5/22.
//

import UIKit

class InterestCustomView: UIView {
    
    weak var delegate: AddSettingPlaceHolderViewDelegate?
    
    var section: InterestSection?
    
    private let backGroundView = UIView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            configureData()
        }
    }
    private lazy var titleLabel = CustomTitleLabel()
    
    private let addTextTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray

        return label
    }()
    private let secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMedium
        label.textColor = .darkGray

        return label
    }()
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.textEditImage, for: .normal)
        button.tintColor = .black
        button.setDemensions(height: 30, width: 30)
        button.addTarget(self, action: #selector(handleEditButton),
                         for: .touchUpInside)
        return button
    }()
    
    convenience init(secondTitle: String, contentText: String, section: InterestSection) {
        
        self.init()
        self.section = section
        
        secondTitleLabel.text = secondTitle
        addTextTitle.text = contentText
        
        backGroundView.layer.cornerRadius = 20
        backGroundView.backgroundColor = .grayColor
      
        
        addSubview(secondTitleLabel)
        secondTitleLabel.anchor(top: topAnchor,
                              left:  leftAnchor,
                              paddingTop: 6, paddingLeft: 20)
     
        addSubview(editButton)
        editButton.centerY(inView: secondTitleLabel,
                           leftAnchor: secondTitleLabel.rightAnchor,
                           paddingLeft: 20)
        
        addSubview(backGroundView)
        backGroundView.anchor(top: secondTitleLabel.bottomAnchor,
                        left: leftAnchor,
                        bottom: bottomAnchor,
                        right: rightAnchor,
                        paddingTop: 20,
                        paddingLeft: 20, paddingBottom: 20,
                        paddingRight: 20)
        
        
        backGroundView.addSubview(addTextTitle)
        addTextTitle.anchor(top: backGroundView.topAnchor,
                            left: backGroundView.leftAnchor,
                            bottom: backGroundView.bottomAnchor,
                            right: backGroundView.rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 20, paddingBottom: 20,
                            paddingRight: 20)
         
    }
    @objc func handleEditButton(_ sender: UIButton) {
        print("DEBUG: **** ideal Date SPENDING EXTRA TIME.....")
       // delegate?.addSettingPlaceHolderView(self, editButton: sender)
    }
    func configureData() {
        
        guard let section = self.section else {return}
       
        switch section {
        case .bio:
            break 
        case .extraTime:
            
            if viewModel.extraTime.isEmpty == false {
                configureTextAttribute(value: viewModel.extraTime)
                addTextTitle.text = viewModel.extraTime
            }
        case .bucketList:
            
            if viewModel.bucketList.isEmpty == false {
                configureTextAttribute(value: viewModel.bucketList)
                addTextTitle.text = viewModel.bucketList
            }
        case .idealType:
            if viewModel.idealType.isEmpty == false {
                configureTextAttribute(value: viewModel.idealType)
                addTextTitle.text = viewModel.idealType
            }
        case .idealDate:
            if viewModel.idealDate.isEmpty == false {
                configureTextAttribute(value: viewModel.idealDate)
                addTextTitle.text = viewModel.idealDate
            }
        }

    }
    func configureTextAttribute(value: String) {
        
        if value.isEmpty == false {
            
            addTextTitle.font = .regularMedium
            addTextTitle.textColor = .black
            
        }
    }
}
