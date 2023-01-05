//
//  ConverstationViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/9/22.
//

import UIKit

struct ConversationViewModel {
    
    private let converstation: Conversation
    var profileImageUrl: URL? {
        return URL(string: converstation.user.imageURLs.first!)
    }
    var timestamp: String {
        let date = converstation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    var displayEmojiMessage: String {
        
        return converstation.message.isEmoji ? "Sent emoji" : converstation.message.text
        
    }
    init(conversation: Conversation) {
        self.converstation = conversation 
    }
}
