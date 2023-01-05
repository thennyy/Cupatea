//
//  AddSpendExtraTimeTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

enum InterestSection {
    case bio
    case extraTime
    case bucketList
    case idealType
    case idealDate
}
protocol AddInterestTableCellDelegate: AnyObject {
    func addInterestTableCell(_ cell: AddInterestTableCell,
                                    addMyFreeTimeEditBtn: UIButton)
    func addInterestTableCell(_ cell: AddInterestTableCell, addMyBucketListEditBtn: UIButton)
}

class AddInterestTableCell: UITableViewCell {
    
    static let identifier = "AddSpendExtraTimeTableCell"
    
    var index = 0
    let backGroundView = UIView()
    
    weak var delegate: AddInterestTableCellDelegate?
    
    var viewModel: SettingsViewModel! {
        didSet {
            configureData()
            
        }
    }
    
    private lazy var myFreeTimeView = InterestCustomView(secondTitle: "I free time doing",
                                                                contentText: "Something you enjoy on your free time", section: InterestSection.extraTime)
    private lazy var myBucketListView = InterestCustomView(secondTitle: "My bucket list",
                                                                  contentText: "What's your your bucket list?", section: InterestSection.bucketList)
    

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Interests"
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
                          paddingTop: 3,
                          paddingLeft: 20)
        
     //   myFreeTimeView.delegate = self
        contentView.addSubview(myFreeTimeView)
        myFreeTimeView.anchor(top: titleLabel.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 9,
                             height: 150)
        
        contentView.addSubview(myBucketListView)
        myBucketListView.anchor(top: myFreeTimeView.bottomAnchor,
                                left: leftAnchor,
                                right: rightAnchor,
                                height: 150)
        

        
    }
    
    func configureButtons() {
        
        myFreeTimeView.editButton.addTarget(self, action: #selector(handleAddFreeTimeButton),
                                            for: .touchUpInside)
        myBucketListView.editButton.addTarget(self, action: #selector(handleAddBucketListButton),
                                              for: .touchUpInside)
        
        
    }
  
    func configureData() {
        myFreeTimeView.viewModel = viewModel
        myBucketListView.viewModel = viewModel
    }
    @objc func handleAddFreeTimeButton(_ sender: UIButton) {
        delegate?.addInterestTableCell(self, addMyFreeTimeEditBtn: sender)
    }
    @objc func handleAddBucketListButton(_ sender: UIButton) {
        delegate?.addInterestTableCell(self, addMyBucketListEditBtn: sender)
    }
}

