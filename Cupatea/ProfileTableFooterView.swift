//
//  ProfileTableFooterView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit
protocol ProfileTableFooterViewDelegate: AnyObject {
    func profileTableFooterView(_ footerView: ProfileTableFooterView,
                                reportButton: UIButton)
}

class ProfileTableFooterView: UIView {
    
    weak var delegate: ProfileTableFooterViewDelegate?
    
    private lazy var reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Report User", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)

        button.tintColor = .black

        button.addTarget(self, action: #selector(handleReportButton),
                         for: .touchUpInside)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(reportButton)
        reportButton.centerX(inView: self,
                             bottomAnchor: bottomAnchor,
                             paddingBottom: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleReportButton(_ sender: UIButton) {
        delegate?.profileTableFooterView(self, reportButton: sender)
    }
}
