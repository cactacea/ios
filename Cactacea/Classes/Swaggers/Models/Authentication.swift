//
// Authentication.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Authentication: Codable {

    public var account: Account
    public var accessToken: String


    
    public init(account: Account, accessToken: String) {
        self.account = account
        self.accessToken = accessToken
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(account, forKey: "account")
        try container.encode(accessToken, forKey: "accessToken")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        account = try container.decode(Account.self, forKey: "account")
        accessToken = try container.decode(String.self, forKey: "accessToken")
    }
}

