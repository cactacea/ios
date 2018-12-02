//
// GetSessionFriendsBody.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct GetSessionFriendsBody: Codable {

    public enum SortType: String, Codable {
        case friendsat = "friendsAt"
        case accountname = "accountName"
    }
    /** Friends which sorted by accountName or friendsAt. Default is friendsAt. */
    public var sortType: SortType?

    public init(sortType: SortType?) {
        self.sortType = sortType
    }


}

