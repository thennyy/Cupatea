//
//  MatchViewViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/15/22.
//

import UIKit

struct MatchViewViewModel {
    
     let currentUser: User
     let matchedUser: User
    
    let matchLabelText: String
    var currentImageUserString: URL?
    var matchedImageUserString: URL?
    
    init(currentUser: User, matchedUser: User){
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        matchLabelText = "You and \(matchedUser.name) have matched"
        guard let currentUserURL = currentUser.imageURLs.first else {return}
        guard let matchedUserURL = matchedUser.imageURLs.first else {return}
        currentImageUserString = URL(string: currentUserURL)
        matchedImageUserString = URL(string: matchedUserURL)
    }
}
