//
// Feed.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Feed: Codable {

    public var id: Int64
    public var message: String
    public var mediums: [Medium]?
    public var tags: [String]?
    public var account: Account?
    public var likeCount: Int64
    public var commentCount: Int64
    public var contentWarning: Bool
    public var contentDeleted: Bool
    public var postedAt: Int64
    public var next: Int64


    
    public init(id: Int64, message: String, mediums: [Medium]?, tags: [String]?, account: Account?, likeCount: Int64, commentCount: Int64, contentWarning: Bool, contentDeleted: Bool, postedAt: Int64, next: Int64) {
        self.id = id
        self.message = message
        self.mediums = mediums
        self.tags = tags
        self.account = account
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.contentWarning = contentWarning
        self.contentDeleted = contentDeleted
        self.postedAt = postedAt
        self.next = next
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encode(message, forKey: "message")
        try container.encodeIfPresent(mediums, forKey: "mediums")
        try container.encodeIfPresent(tags, forKey: "tags")
        try container.encodeIfPresent(account, forKey: "account")
        try container.encode(likeCount, forKey: "likeCount")
        try container.encode(commentCount, forKey: "commentCount")
        try container.encode(contentWarning, forKey: "contentWarning")
        try container.encode(contentDeleted, forKey: "contentDeleted")
        try container.encode(postedAt, forKey: "postedAt")
        try container.encode(next, forKey: "next")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        message = try container.decode(String.self, forKey: "message")
        mediums = try container.decodeIfPresent([Medium].self, forKey: "mediums")
        tags = try container.decodeIfPresent([String].self, forKey: "tags")
        account = try container.decodeIfPresent(Account.self, forKey: "account")
        likeCount = try container.decode(Int64.self, forKey: "likeCount")
        commentCount = try container.decode(Int64.self, forKey: "commentCount")
        contentWarning = try container.decode(Bool.self, forKey: "contentWarning")
        contentDeleted = try container.decode(Bool.self, forKey: "contentDeleted")
        postedAt = try container.decode(Int64.self, forKey: "postedAt")
        next = try container.decode(Int64.self, forKey: "next")
    }
}

