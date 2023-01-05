//
//  UserCollectionViewHeader.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/21/22.
//

import UIKit

protocol UserHeaderViewDelegate: AnyObject {
    func userHeaderView(_ headerView: UserTableHeaderView, dismissButton: UIButton)
    func userHeaderView(_ headerView: UserTableHeaderView, likeButton: UIButton, user: User)
    func userHeaderView(_ headerView: UserTableHeaderView, pinButton: UIButton)
    func userHeaderView(_ headerView: UserTableHeaderView, cancelButton: UIButton, user: User)
}

    
class UserTableHeaderView: UIView {
    
    static let identifier = "userCollectionHeader"
    
    weak var delegate: UserHeaderViewDelegate?
    
    let imageView = UIImageView()
    var index = 0
    var user: User?
    
    private let barStackView = UIStackView()
    
    
    private var viewModel: ProfileViewModel
    
    private var settingViewModel: SettingsViewModel?
    
    private let locationView = LocationView()
    
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
        iv.tintColor = .black
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
    
    private lazy var dismissButton: SendMessageButton = {
        let button = SendMessageButton(type: .system)
        let image = UIImage(systemName: "arrow.down")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19))
        button.setImage(image, for: .normal)
        button.tintColor = .white

        button.addTarget(self, action: #selector(handleDismissal),
                         for: .touchUpInside)
        return button
        
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: .bold, size: 22)
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: .regular, size: 20)
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.xmarkImage, for: .normal)
        button.backgroundColor = .shareWhiteColor
        button.layer.cornerRadius = 45/2
        button.setDemensions(height: 45, width: 45)
        button.tintColor = .systemRed
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        button.addTarget(self, action: #selector(handleCancelButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.pinFillImage, for: .normal)
        button.backgroundColor = .shareWhiteColor
        button.layer.cornerRadius = 45/2
        button.setDemensions(height: 45, width: 45)
        button.tintColor = .accentColor
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        button.addTarget(self, action: #selector(handlePinButton),
                         for: .touchUpInside)

        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.heartFillImage, for: .normal)
        button.backgroundColor = .shareWhiteColor
        button.layer.cornerRadius = 45/2
        button.setDemensions(height: 45, width: 45)
        button.tintColor = .pinkColor
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        button.addTarget(self, action: #selector(handleLikeButton),
                         for: .touchUpInside)

        return button
    }()
    private lazy var reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.dotsImage, for: .normal)
        button.backgroundColor = .shareWhiteColor
        button.layer.cornerRadius = 45/2
        button.tintColor = .black
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.6
        button.addTarget(self, action: #selector(handleLikeButton),
                         for: .touchUpInside)

        return button
    }()


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
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
 
        return cv
        
    }()

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureUI()
        configureBarStackView()
        
        configureUserData()
           
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        imageView.contentMode = .scaleAspectFill

        addSubview(collectionView)
        collectionView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingBottom: 70)
        
        
        addSubview(blurView)
        blurView.anchor(top: topAnchor,
                        left: leftAnchor,
                        bottom: safeAreaLayoutGuide.topAnchor,
                        right: rightAnchor)
        


        let infoStack = UIStackView(arrangedSubviews: [infoLabel,
                                                       locationStackView])


        infoStack.axis = .vertical
        infoStack.spacing = 9

        addSubview(infoStack)
        infoStack.anchor(top: collectionView.bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 12,
                         paddingLeft: 20,
                         paddingRight: 12)

        
        addSubview(pinButton)
        pinButton.centerY(inView: collectionView,
                          rightAnchor: rightAnchor,
                          paddingRight: 20)
        
        addSubview(likeButton)
        likeButton.centerX(inView: pinButton,
                           bottomAnchor: pinButton.topAnchor,
                           paddingBottom: 20)
                          

        addSubview(cancelButton)
        cancelButton.centerX(inView: pinButton,
                             topAnchor: pinButton.bottomAnchor,
                             paddingTop: 20)

        
        addSubview(dismissButton)
        dismissButton.setDemensions(height: 42, width: 42)
        dismissButton.anchor(top: collectionView.bottomAnchor,
                             right: rightAnchor,
                             paddingTop: -42/2,
                             paddingRight: 15)
        
        
    }
    
    func configureBarStackView(){
        
        (0...viewModel.imageCount-1).forEach { _ in
            
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            barStackView.addArrangedSubview(barView)
            self.index += 1
            print("DEBUG: BAR STACKVIEW ",  viewModel.imageCount)
        }
        
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 9,
                            paddingLeft: 9,
                            paddingRight: 9,
                            height: 4)
        
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        

    }
    func configureUserData() {
        
        infoLabel.attributedText = viewModel.userDetailsAttributeString
       
        bioLabel.text = viewModel.bio
        
    }
    

    @objc func handleCancelButton(_ sender: UIButton){
        print("DEBUG: - cancel button pressed")
        guard let user = self.user else {return}
        delegate?.userHeaderView(self, cancelButton: sender, user: user)
        
    }
    @objc func handleLikeButton(_ sender: UIButton) {
        print("DEBUG: - Like button pressed")
        guard let user = self.user else {return}
        delegate?.userHeaderView(self, likeButton: sender, user: user)
    }
    @objc func handlePinButton(_ sender: UIButton) {
        print("DEBUG: - pin button pressed")
        delegate?.userHeaderView(self, pinButton: sender)
    }
    
    @objc func handleDismissal(_ sender: UIButton) {
        delegate?.userHeaderView(self, dismissButton: sender)
    }
    
}
extension UserTableHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        
         cell.imageView.sd_setImage(with: viewModel.imageURLs[indexPath.row])
        
        return cell
    }
 
    
}
extension UserTableHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}
// MARK: - UIScrollViewDelegate

extension UserTableHeaderView: UIScrollViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        barStackView.arrangedSubviews.forEach{($0.backgroundColor = .barDeselectedColor)}
        barStackView.arrangedSubviews[index].backgroundColor = .white
        
    }

}
