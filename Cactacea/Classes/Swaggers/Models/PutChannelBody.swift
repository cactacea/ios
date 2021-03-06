//
// PutChannelBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PutChannelBody: Codable {

    public enum PrivacyType: String, Codable { 
        case everyone = "everyone"
        case follows = "follows"
        case followers = "followers"
        case friends = "friends"
    }
    public enum AuthorityType: String, Codable { 
        case organizer = "organizer"
        case member = "member"
    }
    /** Channel name. */
    public var name: String
    /** Only invited users can join in. */
    public var byInvitationOnly: Bool
    /** Which users can join in. */
    public var privacyType: PrivacyType
    /** Which users can manage a channel. */
    public var authorityType: AuthorityType


    
    public init(name: String, byInvitationOnly: Bool, privacyType: PrivacyType, authorityType: AuthorityType) {
        self.name = name
        self.byInvitationOnly = byInvitationOnly
        self.privacyType = privacyType
        self.authorityType = authorityType
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(name, forKey: "name")
        try container.encode(byInvitationOnly, forKey: "byInvitationOnly")
        try container.encode(privacyType, forKey: "privacyType")
        try container.encode(authorityType, forKey: "authorityType")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decode(String.self, forKey: "name")
        byInvitationOnly = try container.decode(Bool.self, forKey: "byInvitationOnly")
        privacyType = try container.decode(PrivacyType.self, forKey: "privacyType")
        authorityType = try container.decode(AuthorityType.self, forKey: "authorityType")
    }
}

