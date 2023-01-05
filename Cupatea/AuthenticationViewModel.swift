//
//  AuthenticationViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/9/21.
//

import UIKit
protocol AuthenticationViewModel{
    var formIsValid: Bool { get }
}
struct LoginViewModel: AuthenticationViewModel {
    
    var  email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
struct RegistrationViewModel: AuthenticationViewModel{
    var email: String?
    var password: String?
    var name: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && name?.isEmpty == false
    }    
    
}
