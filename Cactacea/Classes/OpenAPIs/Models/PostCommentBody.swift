//
// PostCommentBody.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct PostCommentBody: Codable {

    /** Feed Identifier. */
    public var _id: Int64
    /** A message will be posted. */
    public var commentMessage: String

    public init(_id: Int64, commentMessage: String) {
        self._id = _id
        self.commentMessage = commentMessage
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case commentMessage = "comment_message"
    }


}
