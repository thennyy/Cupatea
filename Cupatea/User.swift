//
//  User.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/1/21.
//

import UIKit

struct User{

    var name: String
    var email: String
    var uid: String
    var imageURLs: [String]
    var age: Int
    var profession: String
    var company: String
    var minSeekingAge: Int
    var maxSeekingAge: Int
    var datePreference: String
    var eduction: String
    var ethnicity: String
    var height: String
    var bio: String
    var starSign: String
    var seeking: String
    var religion: String
    var exercise: String
    var idealType: String
    var idealDate: String
    var bucketList: String
    var extraTime: String
    
    init(dictionary: [String:Any]) {
        
        self.name = dictionary["name"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.imageURLs = dictionary["imageURLs"] as? [String] ?? [String]()
        self.age = dictionary["age"] as? Int ?? 0
        self.profession = dictionary["profession"] as? String ?? ""
        self.company = dictionary["company"] as? String ?? "" 
        self.minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        self.maxSeekingAge = dictionary["maxSeekingAge"] as? Int ?? 100
        self.bio = dictionary["bio"] as? String ?? ""
        self.datePreference = dictionary["datePreference"] as? String ?? ""
        self.eduction = dictionary["education"] as? String ?? ""
        self.ethnicity = dictionary["ethnicity"] as? String ?? ""
        self.height = dictionary["height"] as? String ?? ""
        self.starSign = dictionary["starSign"] as? String ?? ""
        self.seeking = dictionary["seeking"] as? String ?? ""
        self.religion = dictionary["religion"] as? String ?? ""
        self.exercise = dictionary["exercise"] as? String ?? ""
        self.idealDate = dictionary["idealDate"] as? String ?? ""
        self.idealType = dictionary["idealType"] as? String ?? ""
        self.extraTime = dictionary["extraTime"] as? String ?? ""
        self.bucketList = dictionary["bucketList"] as? String ?? ""
        
    }
}
