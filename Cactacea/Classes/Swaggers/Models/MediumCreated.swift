//
// MediumCreated.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class MediumCreated: Codable {

    public var id: Int64
    public var uri: String


    
    public init(id: Int64, uri: String) {
        self.id = id
        self.uri = uri
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encode(uri, forKey: "uri")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        uri = try container.decode(String.self, forKey: "uri")
    }
}

