//
// Account.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Account: Codable {

    public var id: Int64
    public var accountName: String
    public var displayName: String
    public var profileImageUrl: String?
    public var isFriend: Bool
    public var friendRequestInProgress: Bool
    public var following: Bool
    public var isFollower: Bool
    public var followingCount: Int64
    public var followerCount: Int64
    public var friendCount: Int64
    public var feedCount: Int64
    public var muting: Bool
    public var blocking: Bool
    public var web: String?
    public var birthday: Int64?
    public var location: String?
    public var bio: String?
    public var joinedAt: Int64?
    public var next: Int64?


    
    public init(id: Int64, accountName: String, displayName: String, profileImageUrl: String?, isFriend: Bool, friendRequestInProgress: Bool, following: Bool, isFollower: Bool, followingCount: Int64, followerCount: Int64, friendCount: Int64, feedCount: Int64, muting: Bool, blocking: Bool, web: String?, birthday: Int64?, location: String?, bio: String?, joinedAt: Int64?, next: Int64?) {
        self.id = id
        self.accountName = accountName
        self.displayName = displayName
        self.profileImageUrl = profileImageUrl
        self.isFriend = isFriend
        self.friendRequestInProgress = friendRequestInProgress
        self.following = following
        self.isFollower = isFollower
        self.followingCount = followingCount
        self.followerCount = followerCount
        self.friendCount = friendCount
        self.feedCount = feedCount
        self.muting = muting
        self.blocking = blocking
        self.web = web
        self.birthday = birthday
        self.location = location
        self.bio = bio
        self.joinedAt = joinedAt
        self.next = next
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(id, forKey: "id")
        try container.encode(accountName, forKey: "accountName")
        try container.encode(displayName, forKey: "displayName")
        try container.encodeIfPresent(profileImageUrl, forKey: "profileImageUrl")
        try container.encode(isFriend, forKey: "isFriend")
        try container.encode(friendRequestInProgress, forKey: "friendRequestInProgress")
        try container.encode(following, forKey: "following")
        try container.encode(isFollower, forKey: "isFollower")
        try container.encode(followingCount, forKey: "followingCount")
        try container.encode(followerCount, forKey: "followerCount")
        try container.encode(friendCount, forKey: "friendCount")
        try container.encode(feedCount, forKey: "feedCount")
        try container.encode(muting, forKey: "muting")
        try container.encode(blocking, forKey: "blocking")
        try container.encodeIfPresent(web, forKey: "web")
        try container.encodeIfPresent(birthday, forKey: "birthday")
        try container.encodeIfPresent(location, forKey: "location")
        try container.encodeIfPresent(bio, forKey: "bio")
        try container.encodeIfPresent(joinedAt, forKey: "joinedAt")
        try container.encodeIfPresent(next, forKey: "next")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decode(Int64.self, forKey: "id")
        accountName = try container.decode(String.self, forKey: "accountName")
        displayName = try container.decode(String.self, forKey: "displayName")
        profileImageUrl = try container.decodeIfPresent(String.self, forKey: "profileImageUrl")
        isFriend = try container.decode(Bool.self, forKey: "isFriend")
        friendRequestInProgress = try container.decode(Bool.self, forKey: "friendRequestInProgress")
        following = try container.decode(Bool.self, forKey: "following")
        isFollower = try container.decode(Bool.self, forKey: "isFollower")
        followingCount = try container.decode(Int64.self, forKey: "followingCount")
        followerCount = try container.decode(Int64.self, forKey: "followerCount")
        friendCount = try container.decode(Int64.self, forKey: "friendCount")
        feedCount = try container.decode(Int64.self, forKey: "feedCount")
        muting = try container.decode(Bool.self, forKey: "muting")
        blocking = try container.decode(Bool.self, forKey: "blocking")
        web = try container.decodeIfPresent(String.self, forKey: "web")
        birthday = try container.decodeIfPresent(Int64.self, forKey: "birthday")
        location = try container.decodeIfPresent(String.self, forKey: "location")
        bio = try container.decodeIfPresent(String.self, forKey: "bio")
        joinedAt = try container.decodeIfPresent(Int64.self, forKey: "joinedAt")
        next = try container.decodeIfPresent(Int64.self, forKey: "next")
    }
}

