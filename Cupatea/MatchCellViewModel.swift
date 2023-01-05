//
//  MatchCellViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/21/22.
//

import UIKit

struct MatchCellViewModel {
    
    let nameText: String
    var profileImageURL: URL?
    let uid: String
    let age: Int
   
    var userInfo: String {
        return nameText + ", " + "\(age)"
    }
    
    init(match: Match) {
        nameText = match.name
        profileImageURL = URL(string: match.profileImageURL)
        uid = match.uid
        self.age = match.age
    }
}
