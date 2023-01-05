//
//  CardViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/21.
//

import UIKit

class CardViewModel {
    
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    private var imageIndex = 0
    var index: Int {return imageIndex}
    let profession: String
    
    var imageURL: URL?
    
    init(user: User){
        
        self.user = user
        let attributeText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont(name: .medium, size: 24)!])
        attributeText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont(name: .regular, size: 21)!]))
        self.userInfoText = attributeText
        
        self.imageURLs = user.imageURLs
        self.imageURL = URL(string: self.imageURLs[0])
        self.profession = user.profession
    }
    func showNextPhoto() {
        guard imageIndex < imageURLs.count - 1 else {return}
        imageIndex += 1
        imageURL = URL(string: imageURLs[imageIndex])
    }
    func showPreviousPhoto() {
        guard imageIndex > 0 else {return}
        imageIndex -= 1
        imageURL = URL(string: imageURLs[imageIndex])
    }
}
