//
//  FunFactView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/29/21.
//

import UIKit

class FunFactTableView: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "funfactTableCell"
    
    var index = 0
    let bioView = UIView()
    
 
    var viewModel: SettingsViewModel! {
        didSet {
            
            configureData()
        }
    }

    
    private let ethnicityButton = AddBasicFactButton(iconImage: UIImage(named: "person.2")!,
                                                  text: "N/A", section: BasicFactSection.ethnicity)
    private let heightButton = AddBasicFactButton(iconImage: UIImage(named: "height")!,
                                                  text: "N/A", section: BasicFactSection.height)
    private let starSignButton = AddBasicFactButton(iconImage: UIImage(named: "zodiac")!,
                                                    text: "N/A", section: BasicFactSection.starSign)
    private let seekingButton = AddBasicFactButton(iconImage: UIImage(named: "looking")!,
                                                   text: "N/A", section: BasicFactSection.seeking)
    private let religionButton = AddBasicFactButton(iconImage: UIImage(named: "religion")!,
                                                    text: "NA", section: BasicFactSection.religion)
    private let lifeStyleButton = AddBasicFactButton(iconImage: UIImage(named: "exercise")!,
                                                     text: "N/A", section: BasicFactSection.exercise)
    
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
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20)
        
        let stackView1 = UIStackView(arrangedSubviews: [ethnicityButton,
                                                        heightButton,
                                                        starSignButton])
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.spacing = 20
        
        
        
        
        let stackView2 = UIStackView(arrangedSubviews: [seekingButton,
                                                        religionButton,
                                                        lifeStyleButton])

        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.spacing = 20
        
        addSubview(stackView1)
        stackView1.anchor(top: titleLabel.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20,
                          paddingRight: 20, height: 111)
        
        
        addSubview(stackView2)
        stackView2.anchor(top: stackView1.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 20,
                          paddingRight: 20,
                          height: 111)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureData() {
        
        ethnicityButton.viewModel = viewModel
        heightButton.viewModel = viewModel
        starSignButton.viewModel = viewModel
        religionButton.viewModel = viewModel
        lifeStyleButton.viewModel = viewModel
        seekingButton.viewModel = viewModel
        
    }
}
