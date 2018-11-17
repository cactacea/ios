//
// PostDevicePushTokenBody.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct PostDevicePushTokenBody: Codable {

    /** Push notification token. */
    public var pushToken: String?

    public init(pushToken: String?) {
        self.pushToken = pushToken
    }

    public enum CodingKeys: String, CodingKey { 
        case pushToken = "push_token"
    }


}
