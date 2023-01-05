//
//  AddJobTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

protocol AddAboutMeTableCellDelegate: AnyObject {
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editOccupationBtn: UIButton)
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editEducationBtn: UIButton)
    func addAboutMeTableCell(_ cell: AddAboutMeTableCell, editBioBtn: UIButton)
}

class AddAboutMeTableCell: UITableViewCell {
    
    static let identifier = "addAboutMeTableCell"

    weak var delegate: AddAboutMeTableCellDelegate?
    
    var viewModel: SettingsViewModel! {
        didSet {
            configureData()
        }
    }
    
    
    var index = 0
   
    private lazy var jobPlaceHolderView = AddSettingPlaceHolderView(secondTitle: "Occupation", contentText: "What you do for living?", section: AboutMeSection.job)
    private lazy var educationPlaceHolderView = AddSettingPlaceHolderView(secondTitle: "Education",contentText: "School/Institutions", section: AboutMeSection.eduction)
    private lazy var bioPlaceHolderView = AddSettingPlaceHolderView(secondTitle: "My Bio",
                                                                    contentText: "What can you describe yourself as...", section: AboutMeSection.myBio)
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "About Me"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])

        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0, length: attribute.length - 1))
        
        label.attributedText = attribute
        
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        configureUI()
        configureButtons()
        bioPlaceHolderView.delegate = self
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureButtons() {
        
        
        jobPlaceHolderView.editButton.addTarget(self, action: #selector(handleEditOccupationBtn),
                                                for: .touchUpInside)
        educationPlaceHolderView.editButton.addTarget(self, action: #selector(handleEditEducationBtn), for: .touchUpInside)
        bioPlaceHolderView.editButton.addTarget(self, action: #selector(handleEditBioBtn),
                                                for: .touchUpInside)
        
    }
    func configureUI() {
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
  
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                         paddingTop: 20,
                         paddingLeft: 20, height: 36)
        
        contentView.addSubview(jobPlaceHolderView)
        jobPlaceHolderView.anchor(top: titleLabel.bottomAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  paddingTop: 9,
                                  height: 150)
        
        contentView.addSubview(educationPlaceHolderView)
        educationPlaceHolderView.anchor(top: jobPlaceHolderView.bottomAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  height: 130)
        
        contentView.addSubview(bioPlaceHolderView)
        bioPlaceHolderView.anchor(top: educationPlaceHolderView.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor)
                                  
 
    }
    
    func configureData() {
        
        guard let viewModel = self.viewModel else {return}
        jobPlaceHolderView.viewModel = viewModel
        bioPlaceHolderView.viewModel = viewModel
        educationPlaceHolderView.viewModel = viewModel
        
    }
 
    @objc func handleEditOccupationBtn(_ sender: UIButton) {
        delegate?.addAboutMeTableCell(self, editOccupationBtn: sender)
    }
    @objc func handleEditEducationBtn(_ sender: UIButton) {
        delegate?.addAboutMeTableCell(self, editEducationBtn: sender)
    }
    @objc func handleEditBioBtn(_ sender: UIButton) {
        delegate?.addAboutMeTableCell(self, editBioBtn: sender)
    }
    
}
extension AddAboutMeTableCell: AddSettingPlaceHolderViewDelegate {
    func addSettingPlaceHolderView(_ view: AddSettingPlaceHolderView, editButton: UIButton) {
        
    }
    
    func addSettingPlaceHolderView(_ view: AddSettingPlaceHolderView, toViewBio: Bool) {
      
        delegate?.addAboutMeTableCell(self, editBioBtn: UIButton())
        
    }
    
    
}
