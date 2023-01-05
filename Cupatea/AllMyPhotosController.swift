//
//  AllMyPhotosController.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/23/22.
//

import UIKit

class AllMyPhotosController: UIViewController {
    
    var passUser: User? = nil
    var user: User {return passUser!}
    
    private var imageURL: URL?
    
    let imageURLs = [String]()
    private var imageIndex = 0
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let barStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigureUI()
        configureBarStackView()
        configureGestureRecognizer()
        
    }
    
    func congfigureUI() {
        
        view.backgroundColor = .white
        
        imageView.sd_setImage(with: URL(string: user.imageURLs.first!))
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor, paddingBottom: 60)

    }

    func panCard(send: UIPanGestureRecognizer) {
      
        let translation = send.translation(in: nil)
        let degrees = translation.x / 20
        let angle = degrees * .pi/180
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        view.transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)

        
    }
    @objc func handleChangePhotos(sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.view.frame.width / 2
       
        if shouldShowNextPhoto {
            showNextPhoto()
        }else {
            showPreviousPhoto()
        }
        
        imageView.sd_setImage(with: imageURL)
        

        barStackView.arrangedSubviews.forEach{($0.backgroundColor = .barDeselectedColor)}
        barStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
 
    func showNextPhoto() {
        
        guard imageIndex < user.imageURLs.count - 1 else {return}
        imageIndex += 1
        imageURL = URL(string: user.imageURLs[imageIndex])
        
    }
    func showPreviousPhoto() {
        
        guard imageIndex > 0 else {return}
        imageIndex -= 1
        imageURL = URL(string: user.imageURLs[imageIndex])
        
    }
    func configureGestureRecognizer() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhotos(sender:)))
        view.addGestureRecognizer(tap)
    
    }
    func configureBarStackView(){
        
        (0...user.imageURLs.count-1).forEach { _ in
            
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            barStackView.addArrangedSubview(barView)
            
        }
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        view.addSubview(barStackView)
        barStackView.anchor(top: imageView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 9, paddingLeft: 9, paddingRight: 9, height: 4)
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        
        
    }
}
