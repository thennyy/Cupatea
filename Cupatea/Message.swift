//
//  Message.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/7/22.
//

import Firebase

struct Message {
    
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    
    let emojiText: String
    
    let isFromCurrentUser: Bool
    let isEmoji: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.emojiText = dictionary["emojiIcon"] as? String ?? ""
        self.isFromCurrentUser = self.fromId == Auth.auth().currentUser?.uid
    
        self.isEmoji = dictionary["emoji"] as? Bool ?? false
        
    }
    
}

struct Conversation {
    let user: User
    let message: Message 
}
