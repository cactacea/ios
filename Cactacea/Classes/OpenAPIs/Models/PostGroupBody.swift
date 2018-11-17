//
// PostGroupBody.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct PostGroupBody: Codable {

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


}

