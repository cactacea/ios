//
// Message.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Message: Codable {

    public enum MessageType: String, Codable { 
        case text = "text"
        case medium = "medium"
        case stamp = "stamp"
        case groupinvitation = "groupInvitation"
        case groupjoined = "groupJoined"
        case groupleft = "groupLeft"
    }
    public var id: Int64
    public var messageType: MessageType
    public var message: String?
    public var medium: Medium?
    public var account: Account
    public var unread: Bool
    public var accountCount: Int64
    public var readAccountCount: Int64
    public var contentWarning: Bool
    public var contentDeleted: Bool
    public var postedAt: Int64
    public var next: Int64?


    
    public init(id: Int64, messageType: MessageType, message: String?, medium: Medium?, account: Account, unread: Bool, accountCount: Int64, readAccountCount: Int64, contentWarning: Bool, contentDeleted: Bool, postedAt: Int64, next: Int64?) {
        self.id = id
        self.messageType = messageType
        self.message = message
        self.medium = medium
        self.account = account
        self.unread = unread
        self.accountCount = accountCount
        self.readAccountCount = readAccountCount
        self.contentWarning = contentWarning
        self.contentDeleted = contentDeleted
        self.postedAt = postedAt
        self.next = next
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encode(messageType, forKey: "messageType")
        try container.encodeIfPresent(message, forKey: "message")
        try container.encodeIfPresent(medium, forKey: "medium")
        try container.encode(account, forKey: "account")
        try container.encode(unread, forKey: "unread")
        try container.encode(accountCount, forKey: "accountCount")
        try container.encode(readAccountCount, forKey: "readAccountCount")
        try container.encode(contentWarning, forKey: "contentWarning")
        try container.encode(contentDeleted, forKey: "contentDeleted")
        try container.encode(postedAt, forKey: "postedAt")
        try container.encodeIfPresent(next, forKey: "next")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        messageType = try container.decode(MessageType.self, forKey: "messageType")
        message = try container.decodeIfPresent(String.self, forKey: "message")
        medium = try container.decodeIfPresent(Medium.self, forKey: "medium")
        account = try container.decode(Account.self, forKey: "account")
        unread = try container.decode(Bool.self, forKey: "unread")
        accountCount = try container.decode(Int64.self, forKey: "accountCount")
        readAccountCount = try container.decode(Int64.self, forKey: "readAccountCount")
        contentWarning = try container.decode(Bool.self, forKey: "contentWarning")
        contentDeleted = try container.decode(Bool.self, forKey: "contentDeleted")
        postedAt = try container.decode(Int64.self, forKey: "postedAt")
        next = try container.decodeIfPresent(Int64.self, forKey: "next")
    }
}

