//
//  MatchHeader.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/19/22.
//

import UIKit

protocol MatchHeaderDelegate {
    func matchHeader(_ header: MatchHeader, wantsToChatWith: String)
}
class MatchHeader: UICollectionReusableView {

    // MARK: - Properties
    static let identifier = "MatcheHeaderView"
    var delegate: MatchHeaderDelegate?
    
    var matches = [Match]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private let matchesLabel: UILabel = {
        let label = UILabel()
        label.text = "New Matches"
        label.textColor = .label
        label.font = UIFont(name: .medium, size: 18)
        
        return label
    }()
    private let messageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Messages"
        label.textColor = .label
        label.font = UIFont(name: .medium, size: 18)
        
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(MatchCell.self, forCellWithReuseIdentifier: MatchCell.identifier)
        
        return cv
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .grayColor
        addSubview(matchesLabel)
        matchesLabel.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 12,
                            paddingLeft: 12)
        
        addSubview(collectionView)
        collectionView.anchor(top: matchesLabel.bottomAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 12,
                              paddingBottom: 4)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension MatchHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.identifier, for: indexPath) as! MatchCell

        cell.viewModel = MatchCellViewModel(match: matches[indexPath.row])
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension MatchHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = matches[indexPath.row].uid
        delegate?.matchHeader(self, wantsToChatWith: uid)
    }
}

// MARK: -

extension MatchHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 70)
        
    }
}
