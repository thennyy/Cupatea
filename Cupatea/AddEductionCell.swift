//
//  AddEductionTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/3/22.
//

import UIKit


class AddEductionCell: UICollectionViewCell {
    
    static let identifier = "AddEducationCell"
    
    var answerArray: [String]!
  //  var section: AboutMeSection!
    
    var viewModel: AboutMeViewModel! {
        didSet {
            configureAnswer()
        }
    }
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    private let backGroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = 12
        clipsToBounds = true
        configureSelectAnswer(color: .lightGray, height: 1)

        contentView.addSubview(titleTextLabel)
        titleTextLabel.centerX(inView: self)
        titleTextLabel.centerY(inView: self)
        
 
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func configureSelectAnswer(color: UIColor, height: CGFloat) {
        self.layer.borderWidth = height
        self.layer.borderColor = color.cgColor
    }
 
    func configureAnswer() {
     
        for item in viewModel.answerArray {
            if item == viewModel.user.eduction {
                configureSelectAnswer(color: .accentColor, height: 3)
            }else {
                configureSelectAnswer(color: .lightGray, height: 1)
            }
        }
     
    }
}
