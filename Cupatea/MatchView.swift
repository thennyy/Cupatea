//
//  MatchView.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 12/4/21.
//

import UIKit

class MatchView: UIView {
    
    // MARK: - Properties

    var viewModel: MatchViewViewModel! {
        didSet {
            configureData()
        }
    }
    
    
    private let matchedImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "match")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: .medium, size: 21)
        label.numberOfLines = 0
        label.text = "You have matched with"
        return label
    }()
    
    private let currentUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "nat1")?
                                .withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    private let matchedUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "nat1")?
                                .withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    private lazy var sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.titleLabel?.font = UIFont(name: .regular, size: 21)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    private lazy var keepSwipingButton: UIButton = {
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Keep Swiping", for: .normal)
        button.titleLabel?.font = UIFont(name: .regular, size: 21)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleKeepSwiping), for: .touchUpInside)
        return button
    
    }()
    lazy var views = [matchedImageView,
                      matchedUserImageView,
                      currentUserImageView,
                      sendMessageButton,
                      keepSwipingButton]
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureBlurView()
        configureUI()
        configureAnimation()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func handleSendMessage() {
        
    }
    @objc func handleKeepSwiping() {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
        
    }
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }

    }
    // MARK: - Helpers
    func configureData() {
        descriptionLabel.text = viewModel.matchLabelText
        currentUserImageView.sd_setImage(with: viewModel.currentImageUserString)
        matchedUserImageView.sd_setImage(with: viewModel.matchedImageUserString)
    }
    func configureUI() {
        views.forEach { view in
            addSubview(view)
            view.alpha = 1
            
        }
        currentUserImageView.anchor(right: centerXAnchor, paddingRight: 16)
        currentUserImageView.setDemensions(height: 140, width: 140)
        currentUserImageView.layer.cornerRadius = 140/2
        currentUserImageView.centerY(inView: self)
        
        matchedUserImageView.anchor(left: centerXAnchor, paddingLeft:16)
        matchedUserImageView.setDemensions(height: 140, width: 140)
        matchedUserImageView.layer.cornerRadius = 140/2
        matchedUserImageView.centerY(inView: self)
        
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 33, paddingLeft: 48, paddingRight: 48, height: 60)
        
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48, height: 60)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(left: leftAnchor, bottom: currentUserImageView.topAnchor, right: rightAnchor, paddingBottom: 32)

        matchedImageView.anchor(bottom: descriptionLabel.topAnchor, paddingBottom: 10)
        matchedImageView.setDemensions(height: 80, width: 300)
        matchedImageView.centerX(inView: self)


    }
    
    func configureBlurView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(tap)
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }, completion: nil)

    }
    func configureAnimation() {
        
        views.forEach({$0.alpha = 1})
        let angle = 30 * CGFloat.pi / 180
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        
        matchedUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        self.sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        self.keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.matchedUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                
                self.matchedUserImageView.transform = .identity
                self.currentUserImageView.transform = .identity
                
            }
            UIView.animate(withDuration: 0.75, delay: 0.6 * 1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.sendMessageButton.transform = .identity
                self.keepSwipingButton.transform = .identity
            }, completion: nil)
            
            
        } completion: { bool in
            
        }

    }
}
