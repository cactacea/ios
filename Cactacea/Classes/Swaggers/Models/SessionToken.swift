//
// SessionToken.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class SessionToken: Codable {

    public var identifier: String
    public var tokenString: String
    public var userId: Int64?


    
    public init(identifier: String, tokenString: String, userId: Int64?) {
        self.identifier = identifier
        self.tokenString = tokenString
        self.userId = userId
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(identifier, forKey: "identifier")
        try container.encode(tokenString, forKey: "tokenString")
        try container.encodeIfPresent(userId, forKey: "userId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        identifier = try container.decode(String.self, forKey: "identifier")
        tokenString = try container.decode(String.self, forKey: "tokenString")
        userId = try container.decodeIfPresent(Int64.self, forKey: "userId")
    }
}
