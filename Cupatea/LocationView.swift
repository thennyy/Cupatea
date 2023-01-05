//
//  LocationView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/28/22.
//

import UIKit

class LocationView: UIView {
    
    private let mainBackGroundView = UIView()
    
    private let currentLocationStatusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .gray
        label.text = "Your current location"
       // label.textAlignment = .center
        //label.font = UIFont.regularBold
        return label
        
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "Lowell, MA United States"
        label.textColor = .black
        return label
    }()
    private let locationImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .locationImage
        iv.tintColor = .systemRed
        iv.setDemensions(height: 21, width: 21)
        return iv
    }()
    
    private lazy var locationStackView: UIStackView = {
        
       let stackView = UIStackView(arrangedSubviews: [locationImage,
                                         locationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.distribution = .fill
                                        
        return stackView
        
    }()
    private lazy var infoStack: UIStackView = {

        let stackView = UIStackView(arrangedSubviews: [currentLocationStatusLabel,
                                                       locationStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 9
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        configureLocation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func configureUI() {
        
        addSubview(infoStack)
        infoStack.anchor(top: topAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingLeft: 20, paddingRight: 20)
        
        
    }
    private func configureLocation() {

        Service.fetchLocation { currentLocation in
            
            self.locationLabel.text = currentLocation
            
        }

    }
}
