//
//  SettingsViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/25/21.
//

import UIKit
enum SettingsSections: Int, CaseIterable {
   
    case name
    case profession
    case company
    case age
    case bio
    case datePreference
    case ageRange
    case education
    case ethicity
    case height
    case starSign
    case seeking
    case religion
    case excercise
    case extraTime
    case bucketList
    case idealType
    case idealDate

}
struct SettingsViewModel {
    
    private let user: User
    let section: SettingsSections
    var value: String?

 
    var shouldHideInputField: Bool {
        return section == .ageRange
    }
    var shouldHideSlider: Bool {
        return section != .ageRange 
    }
    
    var minAgeSliderValue: Float {
        return Float(user.minSeekingAge)
    }
    var maxAgeSliderValue: Float {
        return Float(user.maxSeekingAge)
    }
    func minAgeLabelText(forValue value: Float) -> String {
        return "Min \(Int(value)): "
    }
    func maxAgeLabelText(forValue value: Float) -> String {
        return "Max \(Int(value)): "
    }
    var profession: String {
        return user.profession
    }
    var workPlace: String {
        return user.company
    }
    var bio: String {
        return user.bio 
    }
    var education: String {
        return user.eduction
    }
    var ethicity: String {
        return user.ethnicity
    }
    var height: String {
        return user.height
    }
    var starSign: String {
        return user.starSign
    }
    var seeking: String {
        return user.seeking
    }
    var religion: String {
        return user.religion
    }
    var excercise: String {
        return user.exercise
    }
    var extraTime: String {
        return user.extraTime
    }
    var bucketList: String {
        return user.bucketList
    }
    var idealType: String {
        return user.idealType
    }
    var idealDate: String {
        return user.idealDate 
    }
    var imageCount: Int {
        return user.imageURLs.count
    }
    
    init(user: User, section: SettingsSections) {
        
        self.user = user
        self.section = section
       
        switch section {
            
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .company:
            value = user.company
        case .age:
            value = "\(user.age)"
        case .bio:
            value = user.bio
        case .datePreference:
            value = user.datePreference
        case .education:
            value = user.eduction
        case .ageRange:
            break
        case .ethicity:
            value = user.ethnicity
        case .height:
            value = user.height
        case .starSign:
            value = user.starSign
        case .seeking:
            value = user.seeking
        case .religion:
            value = user.religion
        case .excercise:
            value = user.exercise
        case .extraTime:
            value = user.extraTime
        case .bucketList:
            value = user.bucketList
        case .idealType:
            value = user.idealType
        case .idealDate:
            value = user.idealDate
        }
    }
}
