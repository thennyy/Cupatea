//
//  UserDetail.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/27/22.
//

import UIKit

struct UserDetail {
    
    var user: User
    
    let interestedIn: String
    let height: String
    let starSign: String
    let seeking: String
    let religion: String
    let idealType: String
    let idealDate: String
    let bucketList: String
    let lifeStyle: String
    let ethnicity: String
    
    init(user: User, dictionary: [String: Any]) {
        
        self.user = user
        
        self.interestedIn = dictionary["interestedIn"] as? String ?? ""
        self.height = dictionary["height"] as? String ?? ""
        self.starSign = dictionary["starSign"] as? String ?? ""
        self.seeking = dictionary["seeking"] as? String ?? ""
        self.religion = dictionary["religion"] as? String ?? ""
        self.idealType = dictionary["idealType"] as? String ?? ""
        self.idealDate = dictionary["idealDate"] as? String ?? ""
        self.bucketList = dictionary["bucketList"] as? String ?? ""
        self.lifeStyle = dictionary["lifeStyle"] as? String ?? ""
        self.ethnicity = dictionary["ethinicity"] as? String ?? ""
    }
    
}
