//
// CommentCreated.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct CommentCreated: Codable {

    public var _id: Int64

    public init(_id: Int64) {
        self._id = _id
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
    }


}
