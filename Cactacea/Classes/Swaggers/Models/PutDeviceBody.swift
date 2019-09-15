//
// PutDeviceBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PutDeviceBody: Codable {

    public enum Status: String, Codable { 
        case active = "active"
        case inactive = "inactive"
    }
    /** Device status. */
    public var status: Status
    /** Unique Device Identifier. */
    public var udid: String
    /** Push notification token. */
    public var pushToken: String?


    
    public init(status: Status, udid: String, pushToken: String?) {
        self.status = status
        self.udid = udid
        self.pushToken = pushToken
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(status, forKey: "status")
        try container.encode(udid, forKey: "udid")
        try container.encodeIfPresent(pushToken, forKey: "pushToken")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        status = try container.decode(Status.self, forKey: "status")
        udid = try container.decode(String.self, forKey: "udid")
        pushToken = try container.decodeIfPresent(String.self, forKey: "pushToken")
    }
}
