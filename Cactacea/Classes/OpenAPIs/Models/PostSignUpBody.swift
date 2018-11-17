//
// PostSignUpBody.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct PostSignUpBody: Codable {

    /** Account name. */
    public var accountName: String
    /** Display name. */
    public var displayName: String?
    /** Account password. */
    public var password: String
    /** Unique Device Identifier. */
    public var udid: String
    /** Profile URL. */
    public var web: String?
    /** Account birthday. */
    public var birthday: Int64?
    /** Account address. */
    public var location: String?
    /** Account bio. */
    public var bio: String?

    public init(accountName: String, displayName: String?, password: String, udid: String, web: String?, birthday: Int64?, location: String?, bio: String?) {
        self.accountName = accountName
        self.displayName = displayName
        self.password = password
        self.udid = udid
        self.web = web
        self.birthday = birthday
        self.location = location
        self.bio = bio
    }


}

