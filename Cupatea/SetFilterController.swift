//
//  SetFilterController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/8/22.
//

import UIKit

class SetFilterController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .regularMedium
        label.text = "Looking to date"

        return label
    }()
    private let ageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .regularMedium
        label.text = "Set age range"

        return label
    }()
    private let distanceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .regularMedium
        label.text = "Set distance"

        return label
    }()
    private lazy var navigationView = AddSettingNavigationView(title: "Set Filter",
                                                               leftButton: .xmarkCircleImage!,
                                                               rightButton: "Update",
                                                               delegate: self)
    
    private let menPrefereDateView = PrefereDateView(title: "Men")
    private let womenPrefereDateView = PrefereDateView(title: "Women")
    private let everyonePrefereDateView = PrefereDateView(title: "Everyone")
    
    private let setFilterSliderView = FilterSliderView()
    private let filterSetDistanceView = FilterSetDistanceView()
    
    private lazy var prefereDateStackView = UIStackView(arrangedSubviews: [menPrefereDateView,
                                                                           womenPrefereDateView,
                                                                           everyonePrefereDateView]).withAttributes(axis: .vertical, spacing: 9, distribution: .fillEqually)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        
    }
    
    func configureUI() {
            
        view.backgroundColor = .white
    
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              height: 60)
    
        view.addSubview(titleLabel)
        titleLabel.anchor(top: navigationView.bottomAnchor,
                          left: view.leftAnchor,
                          paddingTop: 30,
                          paddingLeft: 20)
        
        view.addSubview(prefereDateStackView)
        prefereDateStackView.anchor(top: titleLabel.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    paddingTop: 9,
                                    paddingLeft: 20,
                                    paddingRight: 20,
                                    height: 200)
        
        view.addSubview(ageTitleLabel)
        ageTitleLabel.anchor(top: prefereDateStackView.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        view.addSubview(setFilterSliderView)
        setFilterSliderView.anchor(top: ageTitleLabel.bottomAnchor,
                                   left: view.leftAnchor,
                                   right: view.rightAnchor,
                                   paddingTop: 9,
                                   paddingLeft: 20,
                                   paddingRight: 20,
                                   height: 150)
        
        view.addSubview(distanceTitleLabel)
        distanceTitleLabel.anchor(top: setFilterSliderView.bottomAnchor,
                                  left: view.leftAnchor,
                                  paddingTop: 20,
                                  paddingLeft: 20)
        
        view.addSubview(filterSetDistanceView)
        filterSetDistanceView.anchor(top: distanceTitleLabel.bottomAnchor,
                                     left: view.leftAnchor,
                                     right: view.rightAnchor,
                                     paddingTop: 9,
                                     paddingLeft: 20,
                                     paddingRight: 20,
                                     height: 120)
        
    
    }
}

extension SetFilterController: AddSettingNavigationViewDelegate {
    func addSettingNavigationView(_ view: AddSettingNavigationView, leftButton: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    func addSettingNavigationView(_ view: AddSettingNavigationView, rightButton: UIButton) {
        
    }
    
    
}
