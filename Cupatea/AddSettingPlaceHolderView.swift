//
//  DummyTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/31/22.
//

import UIKit

enum AboutMeSection {
    case job
    case eduction
    case myBio
}
protocol AddSettingPlaceHolderViewDelegate: AnyObject {
    
    func addSettingPlaceHolderView(_ view: AddSettingPlaceHolderView, editButton: UIButton)
    func addSettingPlaceHolderView(_ view: AddSettingPlaceHolderView, toViewBio: Bool)
}

class AddSettingPlaceHolderView: UIView {
 
    let backGroundView = UIView()
    
    weak var delegate: AddSettingPlaceHolderViewDelegate?
    
    var section: AboutMeSection?
    
    var viewModel: SettingsViewModel! {
        didSet {
            configureData() 
        }
    }
  
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
      //  label.text = "Ideal Date"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])
        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0,length: attribute.length - 1))
        
        label.attributedText = attribute
        
        return label
        
    }()
    private let secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .regularMedium
        label.textColor = .darkGray
      //  label.text = "Someone who is..."

        return label
    }()
    private let addTextTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
     //   label.text = "Add here..."

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
    
    convenience init(secondTitle: String, contentText: String, section: AboutMeSection) {

        self.init()
        self.section = section
        
        secondTitleLabel.text = secondTitle
        addTextTitle.text = contentText
       // backgroundColor = .grayColor
        
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
                            paddingTop: 12,
                            paddingLeft: 12,
                            paddingBottom: 12,
                            paddingRight: 12)
        
         
    }

    @objc func handleEditButton(_ sender: UIButton) {
        print("DEBUG: **** ideal Date SPENDING EXTRA TIME.....")
        delegate?.addSettingPlaceHolderView(self, editButton: sender)
    }
    
    func configureData() {
        
        guard let section = self.section else {return}
       
        switch section {
        case .job:
            configureTextAttribute(value: viewModel.profession)
            if viewModel.profession.isEmpty == false {
                addTextTitle.text = viewModel.profession + "\nat \(viewModel.workPlace)"
            }
        case .eduction:
            if viewModel.education.isEmpty == false {
                print("DEBUG: EDUCATION", viewModel.education)
                configureTextAttribute(value: viewModel.education)
                addTextTitle.text = viewModel.education
            }
        case .myBio:
            if viewModel.bio.isEmpty == false {
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleSelectingBioView))
                backGroundView.addGestureRecognizer(tap)
                configureTextAttribute(value: viewModel.bio)
                addTextTitle.text  = viewModel.bio
            }
        }

    }
 
    func configureTextAttribute(value: String) {
        
        if value.isEmpty == false {
            
            addTextTitle.font = .regularMedium
            addTextTitle.textColor = .black
            
        }
    }
    @objc func handleSelectingBioView() {
       print("DEBUG: ADD SETTING PLACE HOLDER ")
        delegate?.addSettingPlaceHolderView(self, toViewBio: true)
        
    }
}

