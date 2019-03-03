//
//  ChatMessage.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/01/13.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import Cactacea

open class ChatMessage: Codable {
    
    public var responseType: String
    public var message: Message?
    
    public init(responseType: String, message: Message?) {
        self.responseType = responseType
        self.message = message
    }
    
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: String.self)
        
        try container.encode(responseType, forKey: "responseType")
        try container.encodeIfPresent(message, forKey: "message")
    }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)
        
        responseType = try container.decode(String.self, forKey: "responseType")
        message = try container.decodeIfPresent(Message.self, forKey: "message")
    }
}

