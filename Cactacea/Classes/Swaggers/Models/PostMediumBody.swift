//
// PostMediumBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostMediumBody: Codable {

    /** Group identifier. */
    public var groupId: Int64
    /** A medium will be posted. */
    public var mediumId: Int64


    
    public init(groupId: Int64, mediumId: Int64) {
        self.groupId = groupId
        self.mediumId = mediumId
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(groupId, forKey: "groupId")
        try container.encode(mediumId, forKey: "mediumId")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        groupId = try container.decode(Int64.self, forKey: "groupId")
        mediumId = try container.decode(Int64.self, forKey: "mediumId")
    }
}

