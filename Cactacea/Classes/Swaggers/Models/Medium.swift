//
// Medium.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Medium: Codable {

    public enum MediumType: String, Codable { 
        case image = "image"
        case movie = "movie"
    }
    public var id: Int64
    public var uri: String
    public var width: Int64
    public var height: Int64
    public var size: Int64
    public var thumbnailUrl: String?
    public var mediumType: MediumType
    public var contentWarning: Bool
    public var contentDeleted: Bool


    
    public init(id: Int64, uri: String, width: Int64, height: Int64, size: Int64, thumbnailUrl: String?, mediumType: MediumType, contentWarning: Bool, contentDeleted: Bool) {
        self.id = id
        self.uri = uri
        self.width = width
        self.height = height
        self.size = size
        self.thumbnailUrl = thumbnailUrl
        self.mediumType = mediumType
        self.contentWarning = contentWarning
        self.contentDeleted = contentDeleted
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encode(uri, forKey: "uri")
        try container.encode(width, forKey: "width")
        try container.encode(height, forKey: "height")
        try container.encode(size, forKey: "size")
        try container.encodeIfPresent(thumbnailUrl, forKey: "thumbnailUrl")
        try container.encode(mediumType, forKey: "mediumType")
        try container.encode(contentWarning, forKey: "contentWarning")
        try container.encode(contentDeleted, forKey: "contentDeleted")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        uri = try container.decode(String.self, forKey: "uri")
        width = try container.decode(Int64.self, forKey: "width")
        height = try container.decode(Int64.self, forKey: "height")
        size = try container.decode(Int64.self, forKey: "size")
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: "thumbnailUrl")
        mediumType = try container.decode(MediumType.self, forKey: "mediumType")
        contentWarning = try container.decode(Bool.self, forKey: "contentWarning")
        contentDeleted = try container.decode(Bool.self, forKey: "contentDeleted")
    }
}

