//
// PostSocialAccountSignUpBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostSocialAccountSignUpBody: Codable {

    /** Account name. */
    public var name: String?
    /** Display name. */
    public var displayName: String?
    /** Social account type. */
    public var providerId: String?
    /** Account password. */
    public var password: String?
    /** Profile URL. */
    public var web: String?
    /** Account birthday. */
    public var birthday: Int64?
    /** Account address. */
    public var location: String?
    /** Account bio. */
    public var bio: String?


    
    public init(name: String?, displayName: String?, providerId: String?, password: String?, web: String?, birthday: Int64?, location: String?, bio: String?) {
        self.name = name
        self.displayName = displayName
        self.providerId = providerId
        self.password = password
        self.web = web
        self.birthday = birthday
        self.location = location
        self.bio = bio
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(displayName, forKey: "display_name")
        try container.encodeIfPresent(providerId, forKey: "provider_id")
        try container.encodeIfPresent(password, forKey: "password")
        try container.encodeIfPresent(web, forKey: "web")
        try container.encodeIfPresent(birthday, forKey: "birthday")
        try container.encodeIfPresent(location, forKey: "location")
        try container.encodeIfPresent(bio, forKey: "bio")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        name = try container.decodeIfPresent(String.self, forKey: "name")
        displayName = try container.decodeIfPresent(String.self, forKey: "display_name")
        providerId = try container.decodeIfPresent(String.self, forKey: "provider_id")
        password = try container.decodeIfPresent(String.self, forKey: "password")
        web = try container.decodeIfPresent(String.self, forKey: "web")
        birthday = try container.decodeIfPresent(Int64.self, forKey: "birthday")
        location = try container.decodeIfPresent(String.self, forKey: "location")
        bio = try container.decodeIfPresent(String.self, forKey: "bio")
    }
}

