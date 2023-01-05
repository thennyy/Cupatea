//
//  MessageViewModel.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 6/7/22.
//

import UIKit
import Firebase
struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .accentColor : .defaultGray
    }

    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .black
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    var profileImageURL: URL? {
        guard let user = message.user else {return nil}
        return URL(string: user.imageURLs.first!)
    }

    var timeStamp: String {
        let timeStamp = message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  NSTimeZone.local
        dateFormatter.dateFormat = "hh:mm a"
        let time = dateFormatter.string(from: timeStamp)
        return time
    }
    var timeStampOnTheRight: Bool {
        return message.isFromCurrentUser
    }
    var timeStampOnTheLeft: Bool {
        return !message.isFromCurrentUser 
    }
    var hideMessageLeftTail: Bool {
        return message.isFromCurrentUser || message.isEmoji
    }
    var hideMessageRightTail: Bool {
        return !message.isFromCurrentUser || message.isEmoji
    }
    var hideMessageTail: Bool {
        return message.isEmoji
    }
    var shouldDisplayEmoji: Bool {
        return !message.isEmoji
    }
    var shouldHideMessageBubble: Bool {
        return message.isEmoji
    }

    var emojiRightAnchor: Bool {
        return message.isFromCurrentUser
    }
    var emojiLeftAnchor: Bool {
        return !message.isFromCurrentUser
    }
    
    init(message: Message) {
        self.message = message
    }
}
