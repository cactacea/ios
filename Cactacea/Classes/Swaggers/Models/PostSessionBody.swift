//
// PostSessionBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostSessionBody: Codable {

    /** User name. */
    public var userName: String
    /** Display name. */
    public var displayName: String?


    
    public init(userName: String, displayName: String?) {
        self.userName = userName
        self.displayName = displayName
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(userName, forKey: "userName")
        try container.encodeIfPresent(displayName, forKey: "displayName")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        userName = try container.decode(String.self, forKey: "userName")
        displayName = try container.decodeIfPresent(String.self, forKey: "displayName")
    }
}
