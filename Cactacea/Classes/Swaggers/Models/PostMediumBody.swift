//
// PostMediumBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostMediumBody: Codable {

    /** Channel identifier. */
    public var channelId: Int64
    /** A medium will be posted. */
    public var mediumId: Int64


    
    public init(channelId: Int64, mediumId: Int64) {
        self.channelId = channelId
        self.mediumId = mediumId
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(channelId, forKey: "channelId")
        try container.encode(mediumId, forKey: "mediumId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        channelId = try container.decode(Int64.self, forKey: "channelId")
        mediumId = try container.decode(Int64.self, forKey: "mediumId")
    }
}

