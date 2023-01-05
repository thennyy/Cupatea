//
//  Match.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 1/21/22.
//

import UIKit

struct Match {
    
    let name: String
    let profileImageURL: String
    let uid: String
    let age: Int
    
    init(dictionary: [String:Any]) {
        
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageURL = dictionary["imageURL"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
    }
}
