//
//  Message+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import MessageKit
import Cactacea

extension Message: MessageType {
    
    /// The sender of the message.
    public var sender: Sender {
        return Sender(id: String(self.account.id), displayName: self.account.displayName)
    }
    
    /// The unique identifier for the message.
    public var messageId: String {
        return String(self.id)
    }
    
    /// The date the message was sent.
    public var sentDate: Date {
        let timeInterval = TimeInterval(self.postedAt)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    /// The kind of message and its underlying kind.
    public var kind: MessageKind {
        if let medium = self.medium {
            if medium.mediumType == .image {
                return .photo(medium)
            } else if medium.mediumType == .movie {
                return .video(medium)
            }
        }
        return .text(self.message ?? "")
    }
}


