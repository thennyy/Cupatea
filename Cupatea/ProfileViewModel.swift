//
//  ProfileViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/29/21.
//

import UIKit

struct ProfileViewModel {
    
    private let user: User
    
    let userDetailsAttributeString: NSAttributedString
    let profession: String
    let workPlace: String
    let bio: String
    let username: String
    let education: String
    
    var imageURLs: [URL] {
        return user.imageURLs.map({ URL(string: $0)!})
    }
    var imageCount: Int {
        return user.imageURLs.count
    }
    var occupation: String {
        return user.company.isEmpty ? user.profession : user.profession + "at " + user.company
    }
    init(user: User) {
       
        self.user = user
        let attributeText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont(name: .bold, size: 22)!])
        attributeText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont(name: .medium, size: 22)!]))
        userDetailsAttributeString = attributeText
        self.profession = user.profession
        self.bio = user.bio
        self.username = user.name
        self.education = user.eduction
        self.workPlace = user.company
    }
    
}
