//
//  CardView.swift
//  EnterAct_TEST
//
//  Created by Thenny Chhorn on 10/19/21.
//

import UIKit
import SDWebImage

enum SwipeDirection: Int{
    case left = -1
    case right = 1
}
protocol CardViewDelegate: AnyObject {
    func cardView(_ view: CardView, wantsToShowProfileFor user: User)
    func cardView(_ view: CardView, didLikeUser: Bool)
    func cardView(_ view: CardView, wantsToSendGiftToUser user: User)
}

class CardView: UIView {
    
    // MARK: - Properties
    let viewModel: CardViewModel
    
    weak var delegate: CardViewDelegate?
    private let bottomControllerView = BottomControlView()
    private let barStackView = UIStackView()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    private let gradientLayer = CAGradientLayer()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
    
        return label
        
    }()
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
    
        return label
        
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.text = " Lowell, MA"
        return label
        
    }()
    lazy var chatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chat"), for: .normal)
        
        return button
    }()
    
    lazy var giftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.giftImage?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
        button.clipsToBounds = true
        button.setDemensions(height: 39, width: 39)
        button.addTarget(self, action: #selector(handleGiftButton), for: .touchUpInside)
        return button
    }()

    lazy var infoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "information")?.withTintColor(.accentColor)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
        return button
    }()
    private let locationImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .locationImage
        iv.tintColor = .white
        iv.setDemensions(height: 18, width: 18)
        return iv
    }()
    private let professionImage: UIImageView = {
        let iv = UIImageView()
       // iv.image = .professionImage
        iv.tintColor = .white
       // iv.setDemensions(height: 21, width: 21)
        return iv
    }()
    private lazy var locationStackView = UIStackView(arrangedSubviews: [locationImage,
                                                                        locationLabel])
    
    private lazy var professionStackView = UIStackView(arrangedSubviews: [professionImage,
                                                                        professionLabel])
    // MARK: - Lifecycle
    
     init(viewModel: CardViewModel) {
         self.viewModel = viewModel
         super.init(frame: .zero)
  
         configureGestureRecognizer()
         
         configureData()
         
         configureGradientLayer()
         configureUI()
         
         configureBarStackView()
         
    }
    func configureData() {
        self.imageView.sd_setImage(with: viewModel.imageURL)
        
        infoLabel.attributedText = viewModel.userInfoText
        
        if viewModel.profession.isEmpty == false {
            professionLabel.text = viewModel.profession
            professionImage.image = .professionImage
            professionImage.setDemensions(height: 18, width: 21)
        }
    }
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -Add actions
    @objc func handlePanGestureRecognizer(sender: UIPanGestureRecognizer){
        
        switch sender.state {
        case .began:
            superview?.subviews.forEach({$0.layer.removeAllAnimations()})
        case .changed:
           panCard(send: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default: break
            
        }
    }
    @objc func handleChangePhotos(sender: UITapGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > imageView.frame.width / 2
       
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        }else {
            viewModel.showPreviousPhoto()
        }
        
        imageView.sd_setImage(with: viewModel.imageURL)
        

        barStackView.arrangedSubviews.forEach{($0.backgroundColor = .barDeselectedColor)}
        barStackView.arrangedSubviews[viewModel.index].backgroundColor = .white

    }
    @objc func handleInfoButton() {
        print("DEBUG: HANDLE BUTTON ")
        delegate?.cardView(self, wantsToShowProfileFor: viewModel.user)
        
    }
    @objc func handleGiftButton() {
        delegate?.cardView(self, wantsToSendGiftToUser: viewModel.user)
    }
    // MARK: - Helpers
    func configureUI() {
        backgroundColor = .white
        
       layer.cornerRadius = 30
       clipsToBounds = true
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.6
        
        addSubview(imageView)
        imageView.fillSuperview()
   
        
        locationStackView.axis = .horizontal
        locationStackView.spacing = 12
        locationStackView.distribution = .fill
        
        
        professionStackView.axis = .horizontal
        professionStackView.spacing = 12
        professionStackView.distribution = .fill
        
        
        
        let infoStackView = UIStackView(arrangedSubviews: [infoLabel,
                                                           locationStackView,
                                                           professionStackView])
        infoStackView.distribution = .fill
        infoStackView.spacing = 9
        infoStackView.axis = .vertical
        
        
        addSubview(infoStackView)
        infoStackView.anchor(left: imageView.leftAnchor,
                         bottom: imageView.bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: 15,
                         paddingBottom: 15,
                         paddingRight: 15)
         
        addSubview(infoButton)
        infoButton.anchor(bottom: imageView.bottomAnchor,
                          right: imageView.rightAnchor,
                           paddingBottom: 15,
                           paddingRight: 9,
                           width: 33, height: 33)
         
       
        addSubview(giftButton)
        giftButton.centerX(inView: infoButton,
                           bottomAnchor: infoButton.topAnchor,
                           paddingBottom: 30)
  
    }
    
    func createPageController() -> UIPageControl {
        let pageController = UIPageControl()
        pageController.numberOfPages = viewModel.imageURLs.count
        pageController.currentPageIndicatorTintColor = .accentColor
        pageController.pageIndicatorTintColor = .white
        pageController.isEnabled = false
        return pageController
    }
    func panCard(send: UIPanGestureRecognizer) {
      
        let translation = send.translation(in: nil)
        let degrees = translation.x / 20
        let angle = degrees * .pi/180
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
        
    }
    func resetCardPosition(sender: UIPanGestureRecognizer){
        
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
          
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }else {
            
                self.transform = .identity
            }
        } completion: { _ in
            if shouldDismissCard {

                let didLike = direction == .right
                self.delegate?.cardView(self, didLikeUser: didLike)
            }
        }


    }
    func configureBarStackView(){
        
        (0...viewModel.imageURLs.count-1).forEach { _ in
            
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            barStackView.addArrangedSubview(barView)
            
        }
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        addSubview(barStackView)
        barStackView.anchor(top:imageView.topAnchor,
                            left: imageView.leftAnchor,
                            right: imageView.rightAnchor,
                            paddingTop: 6,
                            paddingLeft: 20,
                            paddingRight: 20,
                            height: 4)
        barStackView.spacing = 2
        barStackView.distribution = .fillEqually
        
        
    }
    func configureGradientLayer() {
       
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        imageView.layer.addSublayer(gradientLayer)
        
    }

    func configureGestureRecognizer() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(sender:)))
        addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhotos(sender:)))
 
        addGestureRecognizer(tap)
    
    }
 
 
}
