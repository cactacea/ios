//
// NotificationSetting.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class NotificationSetting: Codable {

    public var tweet: Bool
    public var comment: Bool
    public var friendRequest: Bool
    public var message: Bool
    public var channelMessage: Bool
    public var invitation: Bool
    public var showMessage: Bool


    
    public init(tweet: Bool, comment: Bool, friendRequest: Bool, message: Bool, channelMessage: Bool, invitation: Bool, showMessage: Bool) {
        self.tweet = tweet
        self.comment = comment
        self.friendRequest = friendRequest
        self.message = message
        self.channelMessage = channelMessage
        self.invitation = invitation
        self.showMessage = showMessage
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(tweet, forKey: "tweet")
        try container.encode(comment, forKey: "comment")
        try container.encode(friendRequest, forKey: "friendRequest")
        try container.encode(message, forKey: "message")
        try container.encode(channelMessage, forKey: "channelMessage")
        try container.encode(invitation, forKey: "invitation")
        try container.encode(showMessage, forKey: "showMessage")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        tweet = try container.decode(Bool.self, forKey: "tweet")
        comment = try container.decode(Bool.self, forKey: "comment")
        friendRequest = try container.decode(Bool.self, forKey: "friendRequest")
        message = try container.decode(Bool.self, forKey: "message")
        channelMessage = try container.decode(Bool.self, forKey: "channelMessage")
        invitation = try container.decode(Bool.self, forKey: "invitation")
        showMessage = try container.decode(Bool.self, forKey: "showMessage")
    }
}
