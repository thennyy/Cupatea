//
//  AddBasicFactTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

protocol AddBasicFactTableCellDelegate: AnyObject {
    
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, starSignBtn: UIButton)
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, heightBtn: UIButton)
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, seekingBtn: UIButton)
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, religionBtn: UIButton)
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, genderButton: UIButton)
    func addBasicFactTableCell(_ cell: AddBasicFactTableCell, lifeStyle: UIButton)
    
}

class AddBasicFactTableCell: UITableViewCell {
    
    static let identifier = "AddBasicFactTableCell"
    
    weak var delegate: AddBasicFactTableCellDelegate?
    
    var index = 0
    
    var viewModel: SettingsViewModel! {
        didSet {
            
            configureData()
        }
    }
    private let genderButton = AddBasicFactButton(iconImage: UIImage(named: "person.2")!,
                                                  text: "Add", section: BasicFactSection.ethnicity)
    private let heightButton = AddBasicFactButton(iconImage: UIImage(named: "height")!,
                                                  text: "Add", section: BasicFactSection.height)
    private let starSignButton = AddBasicFactButton(iconImage: UIImage(named: "zodiac")!,
                                                    text: "Add", section: BasicFactSection.starSign)
    private let seekingButton = AddBasicFactButton(iconImage: UIImage(named: "looking")!,
                                                   text: "Add", section: BasicFactSection.seeking)
    private let religionButton = AddBasicFactButton(iconImage: UIImage(named: "religion")!,
                                                    text: "Add", section: BasicFactSection.religion)
    private let lifeStyleButton = AddBasicFactButton(iconImage: UIImage(named: "exercise")!,
                                                     text: "Add", section: BasicFactSection.exercise)
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Basic Facts"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])

        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0, length: attribute.length - 1))
        
        label.attributedText = attribute
        
        return label
    }()
    
    private let secondTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.text = "What can you be describe yourself as..."

        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        configureUI()
        configureDelegation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          paddingTop: 20,
                          paddingLeft: 20)

        
        let stackView1 = UIStackView(arrangedSubviews: [genderButton,
                                                        heightButton,
                                                        starSignButton])
        stackView1.axis = .horizontal
        stackView1.spacing = 20
        stackView1.distribution = .fillEqually
        
        
        let stackView2 = UIStackView(arrangedSubviews: [seekingButton,
                                                        religionButton,
                                                        lifeStyleButton])
        stackView2.axis = .horizontal
        stackView2.spacing = 20
        stackView2.distribution = .fillEqually
        
        
        contentView.addSubview(stackView1)
        stackView1.anchor(top: titleLabel.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20,
                          paddingRight: 20,
                          height: 111)
        
        contentView.addSubview(stackView2)
        stackView2.anchor(top: stackView1.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20,
                          paddingRight: 20,
                          height: 111)
        
    }
    func configureData() {
        
        genderButton.viewModel = viewModel
        heightButton.viewModel = viewModel
        starSignButton.viewModel = viewModel
        religionButton.viewModel = viewModel
        lifeStyleButton.viewModel = viewModel
        seekingButton.viewModel = viewModel
        
    }
    
    func configureDelegation() {
   
        starSignButton.addTarget(self, action: #selector(handleStarSignButton), for: .touchUpInside)
        seekingButton.addTarget(self, action: #selector(handleSeekingButton), for: .touchUpInside)
        heightButton.addTarget(self, action: #selector(handleHeightButton), for: .touchUpInside)
        religionButton.addTarget(self, action: #selector(handleReligionButton), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(handleGenderButton), for: .touchUpInside)
        lifeStyleButton.addTarget(self, action: #selector(handleLifeStyleButton), for: .touchUpInside)
        
    }
    @objc func handleStarSignButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, starSignBtn: sender)
    }
    @objc func handleHeightButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, heightBtn: sender)
    }
    @objc func handleSeekingButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, seekingBtn: sender)
    }
    @objc func handleReligionButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, religionBtn: sender)
    }
    @objc func handleLifeStyleButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, lifeStyle: sender)
    }
    @objc func handleGenderButton(_ sender: UIButton) {
        delegate?.addBasicFactTableCell(self, genderButton: sender)
    }
}


