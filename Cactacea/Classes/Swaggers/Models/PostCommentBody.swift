//
// PostCommentBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostCommentBody: Codable {

    /** Tweet Identifier. */
    public var id: Int64
    /** Reply comment identifier. */
    public var replyId: Int64?
    /** A message will be posted. */
    public var message: String


    
    public init(id: Int64, replyId: Int64?, message: String) {
        self.id = id
        self.replyId = replyId
        self.message = message
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encodeIfPresent(replyId, forKey: "replyId")
        try container.encode(message, forKey: "message")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        replyId = try container.decodeIfPresent(Int64.self, forKey: "replyId")
        message = try container.decode(String.self, forKey: "message")
    }
}

