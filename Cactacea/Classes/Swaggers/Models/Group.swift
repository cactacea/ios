//
// Group.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Group: Codable {

    public enum PrivacyType: String, Codable { 
        case everyone = "everyone"
        case following = "following"
        case followers = "followers"
        case friends = "friends"
    }
    public enum AuthorityType: String, Codable { 
        case owner = "owner"
        case member = "member"
    }
    public var id: Int64
    public var name: String?
    public var message: Message?
    public var invitationOnly: Bool
    public var privacyType: PrivacyType
    public var authorityType: AuthorityType
    public var accountCount: Int64
    public var lastPostedAt: Int64?
    public var organizedAt: Int64
    public var next: Int64?


    
    public init(id: Int64, name: String?, message: Message?, invitationOnly: Bool, privacyType: PrivacyType, authorityType: AuthorityType, accountCount: Int64, lastPostedAt: Int64?, organizedAt: Int64, next: Int64?) {
        self.id = id
        self.name = name
        self.message = message
        self.invitationOnly = invitationOnly
        self.privacyType = privacyType
        self.authorityType = authorityType
        self.accountCount = accountCount
        self.lastPostedAt = lastPostedAt
        self.organizedAt = organizedAt
        self.next = next
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(message, forKey: "message")
        try container.encode(invitationOnly, forKey: "invitationOnly")
        try container.encode(privacyType, forKey: "privacyType")
        try container.encode(authorityType, forKey: "authorityType")
        try container.encode(accountCount, forKey: "accountCount")
        try container.encodeIfPresent(lastPostedAt, forKey: "lastPostedAt")
        try container.encode(organizedAt, forKey: "organizedAt")
        try container.encodeIfPresent(next, forKey: "next")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        message = try container.decodeIfPresent(Message.self, forKey: "message")
        invitationOnly = try container.decode(Bool.self, forKey: "invitationOnly")
        privacyType = try container.decode(PrivacyType.self, forKey: "privacyType")
        authorityType = try container.decode(AuthorityType.self, forKey: "authorityType")
        accountCount = try container.decode(Int64.self, forKey: "accountCount")
        lastPostedAt = try container.decodeIfPresent(Int64.self, forKey: "lastPostedAt")
        organizedAt = try container.decode(Int64.self, forKey: "organizedAt")
        next = try container.decodeIfPresent(Int64.self, forKey: "next")
    }
}

