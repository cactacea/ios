//
// FriendRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct FriendRequest: Codable {

    public enum RequestStatus: String, Codable {
        case noresponded = "noResponded"
        case accepted = "accepted"
        case rejected = "rejected"
    }
    public var _id: Int64
    public var account: Account
    public var requestStatus: RequestStatus
    public var requestedAt: Int64
    public var next: Int64?

    public init(_id: Int64, account: Account, requestStatus: RequestStatus, requestedAt: Int64, next: Int64?) {
        self._id = _id
        self.account = account
        self.requestStatus = requestStatus
        self.requestedAt = requestedAt
        self.next = next
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case account
        case requestStatus
        case requestedAt
        case next
    }


}

