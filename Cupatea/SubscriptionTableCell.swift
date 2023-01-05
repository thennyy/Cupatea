//
//  SubscriptionTableCell.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

class SubscriptionTableCell: UITableViewCell {
    
    static let identifier = "subscriptionTableCell"
   
    var index = 0
    private let titleArray = ["VIP","Premium"]
    private let pricesArray = ["$8.99", "$10.99"]
    
    private let contentArray = ["Unlock your unlimited pins, more privileges, $500 credit for gifts","See who pins you, unlimited swipes, $1000 credit for gifts"]
    
    var viewModel: SettingsViewModel!
    
    private let locationView = LocationView()
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width,
                           height: self.frame.width + 30)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(SubScriptionCollectionCell.self, forCellWithReuseIdentifier: SubScriptionCollectionCell.identifier)
      //  cv.backgroundColor = .green
        return cv
        
        
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        contentView.addSubview(collectionView)
        
        collectionView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 3,
                              paddingLeft: 20,
                              paddingBottom: 90,
                              paddingRight: 20)
        
        contentView.addSubview(locationView)
        locationView.anchor(top: collectionView.bottomAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 20,
                            height: 54)
        
    }
}

extension SubscriptionTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubScriptionCollectionCell.identifier, for: indexPath) as! SubScriptionCollectionCell
        
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.secondTitle.text = contentArray[indexPath.row]
        cell.selectPriceButton.setTitle(pricesArray[indexPath.row],
                                        for: .normal)
        
        cell.viewModel = viewModel
        
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .lavendar
        case 1:
            cell.backgroundColor = .black
        default:
            cell.backgroundColor = .black
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: SELECTING INDEX ", indexPath.row)
    }
}
extension SubscriptionTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 330, height: 200)
        
    }
}
