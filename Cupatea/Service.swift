//
//  Service.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 11/12/21.
//

import UIKit
import Firebase
import SDWebImage
import CloudKit
import CoreLocation

struct Service {
    
    static func saveContentToDataBase(_ text: String, section: InterestSection, completion: @escaping([String: Any]) -> Void) {
        
        switch section {
        case .bio:
            completion(["bio": text])
        case .extraTime:
            completion(["extraTime": text])
        case .bucketList:
            completion(["bucketList": text])
        case .idealType:
            completion(["idealType": text])
        case .idealDate:
            completion(["idealDate": text])
      
        }
        
    }
    static func countingOccupationWord(_ textField: UITextField, completion: @escaping(String) -> Void) {
            if textField.text?.isEmpty == false {
                if let count = textField.text?.count {
                    if count > 0 {
                        let wordCount = 50 - count
                        completion(String(wordCount))
                    }
                }
            }else {
                completion(String(50))
            }
    }
    static func countingBioTextView(_ textView: UITextView, completion: @escaping(String) -> Void) {
            if textView.text?.isEmpty == false {
                if let count = textView.text?.count {
                    if count > 0 {
                        let wordCount = 300 - count
                        completion(String(wordCount))
                    }
                }
            }else {
                completion(String(300))
            }
    }
    static func fetchLocation(_ completion: @escaping(String) -> Void) {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        guard let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude) else {return}
        guard let longtitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude) else {return}
        
        let location = CLLocation(latitude: latitude, longitude: longtitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, error in
            if error != nil {
                
                print("DEBUG: NIL")
                return
            }else {
                if let placemark = placeMarks?.first {
                    
                    let placeMarkModel = PlaceMarker(with: placemark)
                    let location = placeMarkModel.formattedAddress
                    
                    completion(location)
                }
            }
            
        }
        
    }
 
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    static func fetchUsers(forCurrentuser user: User, completion: @escaping([User]) -> Void){
        var users = [User]()
        let querry = COLLECTION_USERS
            .whereField("age", isGreaterThanOrEqualTo: user.minSeekingAge)
            .whereField("age", isLessThanOrEqualTo: user.maxSeekingAge)
        fetchSwipes { swipesUserIDs in
            querry.getDocuments { snapshot, error in
                guard let snapshot = snapshot else {return}
                snapshot.documents.forEach({ document in
                    let dictionary = document.data()
                    let user = User(dictionary: dictionary)
                    guard user.uid != Auth.auth().currentUser?.uid else {return}
                    users.append(user)

                })
                completion(users)
            }
        }
     
    }
    static func fetchSwipes(completion: @escaping([String:Bool]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            
            guard let data = snapshot?.data() as? [String:Bool] else {
                completion([String:Bool]())
                return }
            completion(data)
        }
     
    }
    static func fetchMatches(completion: @escaping([Match]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_MATCHES_MESSAGES.document(uid).collection("matches").getDocuments { snapshot, error in
            guard let data = snapshot else {return}
            let matches = data.documents.map({Match(dictionary: $0.data())})
            completion(matches)
        }
    }
    static func checkIfMatchExists(forUser user: User, completion: @escaping(Bool) -> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
       
        COLLECTION_SWIPES.document(user.uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else {return}
            guard let didMatch = data[currentUid] as? Bool else {return}
            completion(didMatch)
        }
    }
    // MARK: - Save
    static func saveUserData(fetchedUser: User, completion: @escaping(Error?) -> Void) {
        
        let data = ["uid" : fetchedUser.uid,
                    "name" : fetchedUser.name,
                    "imageURLs": fetchedUser.imageURLs,
                    "age" : fetchedUser.age,
                    "bio": fetchedUser.bio,
                    "education": fetchedUser.eduction,
                    "profession" : fetchedUser.profession,
                    "company": fetchedUser.company,
                    "minSeekingAge" : fetchedUser.minSeekingAge,
                    "maxSeekingAge" : fetchedUser.maxSeekingAge] as [String:Any]
        
        COLLECTION_USERS.document(fetchedUser.uid).setData(data, completion: completion)
        
    }
    static func updateUserPreference(userId: String, data: [String: Any], completion: @escaping(User) -> Void) {
        
        COLLECTION_USERS.document(userId).updateData(data)
        fetchUser(withUid: userId) { user in
            completion(user)
        }
        
        
    }
    static func saveUserPreference(user: User, userDetail: UserDetail, completion: @escaping(Error?) -> Void) {
     
        let data = ["interestedIn": userDetail.interestedIn,
                    "height": userDetail.height,
                    "starSign": userDetail.starSign,
                    "seeking": userDetail.seeking,
                    "religion": userDetail.religion,
                    "idealType": userDetail.idealType,
                    "idealDate": userDetail.idealDate,
                    "bucketList": userDetail.bucketList,
                    "lifeStyle": userDetail.lifeStyle,
                    "ethnicity": userDetail.ethnicity ]
        
        COLLECTION_USERS.document(user.uid).updateData(data, completion: completion)
        
    }
    
    static func saveSwipe(forUser user: User, isLike: Bool, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
       
        COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            let data = [user.uid : isLike]
            if snapshot?.exists == true {
                COLLECTION_SWIPES.document(uid).updateData(data, completion: completion)
            }else {
                COLLECTION_SWIPES.document(uid).setData(data, completion: completion)
            }
        }
    }
    // MARK: - Upload
    static func uploadMatch(currentUser: User, matchedUser: User) {
        
        guard let currentUserImageURL = currentUser.imageURLs.first else {return}
        guard let matchedUserImageURL = matchedUser.imageURLs.first else {return}

        let currentUserData:[String:Any] = ["uid" : currentUser.uid,
                                            "age": currentUser.age,
                                            "name": currentUser.name,
                                            "imageURL" : currentUserImageURL]
        
        let matchedUserData:[String:Any]  = ["uid": matchedUser.uid,
                                             "age": matchedUser.age,
                                             "name": matchedUser.name,
                                             "imageURL" : matchedUserImageURL]
        
        COLLECTION_MATCHES_MESSAGES.document(currentUser.uid).collection("matches").document(matchedUser.uid).setData(matchedUserData)
        
      
        COLLECTION_MATCHES_MESSAGES.document(matchedUser.uid).collection("matches").document(matchedUser.uid).setData(currentUserData)
        
    }
    
    
    // MARK: - Upload Image
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
       
        guard let imageData = image.jpegData(compressionQuality: 0.73) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/image/\(filename)")
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: error \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
            }
        }
    
    }
    static func deleteImage(user: User, imageString: String, index: Int) {
            
       // COLLECTION_USERS.document(user.uid).updateData("imageURLs" : [index: ])
      
        COLLECTION_USERS.document(user.uid).collection("imageURLs").document("\(index)").delete { err in
            if let error = err {
                print("DEBUG: image is failed to be deleted \(error.localizedDescription)")
                return
            }
            print("SUCCESSFULLY DELETED")
            
        }
        

        
    }
    // MARK: - Fetch Message Conversation
    
    static func fetchConverstation(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                var userId = message.toId
                if userId == Auth.auth().currentUser?.uid {
                    userId = message.fromId
                }
                self.fetchUser(withUid: userId ) { user in
                    let converstation = Conversation(user: user, message: message)
                    conversations.append(converstation)
                    completion(conversations)
                    
                }
                
                })
              
            }
        
    }
    // MARK: - Fetch Message
    
    static func fetchMessage(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
    // MARK: - Load Image
    static func loadImage(with url: URL, completion: @escaping(UIImage) -> Void) {
        SDWebImageManager.shared.loadImage(with: url,
                                           options: .continueInBackground,
                                           progress: nil)
        { image, _, _, _, _, _ in
            guard let image = image else {return}
            completion(image)
        }
    }
    // MARK: - upload Message
    
    static func uploadMessage(_ message: String, to user: User, sentEmoji emoji: Bool = false, emojiIcon emoIconText: String = "",  completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let data = ["text" : message,
                    "fromId": currentUid,
                    "toId" : user.uid,
                    "emoji" : emoji,
                    "emojiIcon" : emoIconText,
                    "timestamp" : Timestamp(date: Date())] as [String:Any]
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
            
        }
    }
}
