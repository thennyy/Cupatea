//
//  SelectAnswerViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/7/22.
//

import UIKit

struct AboutMeViewModel {
    
    var user: User
    var answerArray: [String]
    
    var selectedEductionColor: UIColor {
        return user.eduction.isEmpty ? .lightGray : .accentColor
    }
    var selectedEthnicityColor: UIColor {
        return user.ethnicity.isEmpty ? .lightGray : .accentColor
    }
    var selectedStarSignColor: UIColor {
        return user.starSign.isEmpty ? .lightGray : .accentColor
    }
    var selectedSeekingColor: UIColor {
        return user.seeking.isEmpty ? .lightGray : .accentColor
    }
    var selectedReligionColor: UIColor {
        return user.religion.isEmpty ? .lightGray : .accentColor
    }
    var selectedExerciseColor: UIColor {
        return user.exercise.isEmpty ? .lightGray : .accentColor
    }
    
    init(answerArray: [String], user: User) {
        self.user = user
        self.answerArray = answerArray 
    }
    
}
