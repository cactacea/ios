//
// PutPasswordBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PutPasswordBody: Codable {

    /** User new password. */
    public var newPassword: String


    
    public init(newPassword: String) {
        self.newPassword = newPassword
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(newPassword, forKey: "newPassword")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        newPassword = try container.decode(String.self, forKey: "newPassword")
    }
}

