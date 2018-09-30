//
// PostSocialAccountBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostSocialAccountBody: Codable {

    /** Social account type. */
    public var providerId: String?


    
    public init(providerId: String?) {
        self.providerId = providerId
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(providerId, forKey: "provider_id")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        providerId = try container.decodeIfPresent(String.self, forKey: "provider_id")
    }
}

