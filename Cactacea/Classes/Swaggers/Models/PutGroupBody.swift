//
// PutGroupBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PutGroupBody: Codable {

    public enum PrivacyType: String, Codable { 
        case everyone = "everyone"
        case follows = "follows"
        case followers = "followers"
        case friends = "friends"
    }
    public enum AuthorityType: String, Codable { 
        case owner = "owner"
        case member = "member"
    }
    /** Group name. */
    public var name: String
    /** Only invited accounts can join in. */
    public var byInvitationOnly: Bool
    /** Which accounts can join in. */
    public var privacyType: PrivacyType
    /** Which accounts can manage a group. */
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
        try container.encode(byInvitationOnly, forKey: "by_invitation_only")
        try container.encode(privacyType, forKey: "privacy_type")
        try container.encode(authorityType, forKey: "authority_type")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decode(String.self, forKey: "name")
        byInvitationOnly = try container.decode(Bool.self, forKey: "by_invitation_only")
        privacyType = try container.decode(PrivacyType.self, forKey: "privacy_type")
        authorityType = try container.decode(AuthorityType.self, forKey: "authority_type")
    }
}

