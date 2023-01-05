//
//  MyProfileViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/21/22.
//

import UIKit

enum MyProfileSections: Int, CaseIterable  {
    
    case subscription
    case credit
    case settings
    case help
    
    var description: String {
        switch self {
        case .subscription:
            return "Subscription"
        case .credit:
            return "Credits"
        case .settings:
            return "Settings"
        case .help:
            return ""
            
        }
    }
}
struct MyProfileViewModel {
    
    private let user: User
    var value: String? 
         
    init(user: User) {
        self.user = user

  
    }
    
    
}
