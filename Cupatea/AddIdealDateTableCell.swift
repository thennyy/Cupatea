//
//  File.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//


import UIKit
protocol AddIdealDateTableCellDelegate: AnyObject {
    
    func addIdealDateTableCell(_ cell: AddIdealDateTableCell,
                                    editIdealTypeButton: UIButton)
    func addIdealDateTableCell(_ cell: AddIdealDateTableCell,
                                    editIdealDateButton: UIButton)
    
}
class AddIdealDateTableCell: UITableViewCell {
    
    static let identifier = "idealDateCell"
    
    var index = 0
    let backGroundView = UIView()
    
    weak var delegate: AddIdealDateTableCellDelegate?
    var viewModel: SettingsViewModel! {
        didSet{
            configureData()
        }
    }
    private lazy var idealTypeView = InterestCustomView(secondTitle: "Ideal type",
                                                               contentText: "What type of person you would get along/enjoy the company", section: InterestSection.idealType)
    
    private lazy var idealDateView = InterestCustomView(secondTitle: "Ideal date",
                                                               contentText: "Some activities/places you both could enjoy", section: InterestSection.idealDate)
    
    
  
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Ideal Date"
        let font = UIFont.funFactTitleBold
        let attribute = NSMutableAttributedString(string: label.text!,
                                                  attributes: [.font: font!])
        attribute.addAttribute(.kern, value: 9,
                               range: NSRange(location: 0,length: attribute.length - 1))
        
        label.attributedText = attribute
        
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureButtons()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 20)
        
        contentView.addSubview(idealTypeView)
        
        idealTypeView.anchor(top: titleLabel.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 9,
                             height: 150)
        
        contentView.addSubview(idealDateView)
        idealDateView.anchor(top: idealTypeView.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             height: 150)
   
         
    }
    func configureData() {
        idealTypeView.viewModel = viewModel
        idealDateView.viewModel = viewModel
    }
    func configureButtons() {
        idealTypeView.editButton.addTarget(self, action: #selector(handleAddIdealTypeButton), for: .touchUpInside)
        idealDateView.editButton.addTarget(self, action: #selector(handleAddIdealDateButton), for: .touchUpInside)
    }
    @objc func handleAddIdealTypeButton(_ sender: UIButton) {
        delegate?.addIdealDateTableCell(self, editIdealTypeButton: sender)
    }
    @objc func handleAddIdealDateButton(_ sender: UIButton) {
        delegate?.addIdealDateTableCell(self, editIdealDateButton: sender)
    }
}

