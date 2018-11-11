//
// SocialAccount.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class SocialAccount: Codable {

    public var providerId: String
    public var providerKey: String


    
    public init(providerId: String, providerKey: String) {
        self.providerId = providerId
        self.providerKey = providerKey
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(providerId, forKey: "providerId")
        try container.encode(providerKey, forKey: "providerKey")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        providerId = try container.decode(String.self, forKey: "providerId")
        providerKey = try container.decode(String.self, forKey: "providerKey")
    }
}
