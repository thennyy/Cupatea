//
//  AuthService.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/12/21.
//

import UIKit
import Firebase

struct AuthCredential {
    let email: String
    let password: String
    let name: String
    let profileImage: UIImage
}
struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String,
                          completion: @escaping((Error?) -> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(error)
                print("DEBUG: ERROR TO LOG IN \(error.localizedDescription)")
                return
            }
            print("DEBUG: successfully logined")
        }
      //  Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    static func registerUser(withCredential credential: AuthCredential, completion: @escaping((Error?) -> Void)) {
        Service.uploadImage(image: credential.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                if let error = error {
                    completion(error)
                    return
                }
                guard let uid = result?.user.uid else {return}
                let data: [String:Any] = ["name": credential.name,
                                          "email" : credential.email,
                                          "imageURLs" : [imageURL],
                                          "uid" : uid,
                                          "age" : 30]
              
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}
