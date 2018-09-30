//
// PostGroupReportBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class PostGroupReportBody: Codable {

    public enum ReportType: String, Codable { 
        case _none = "none"
        case spam = "spam"
        case inappropriate = "inappropriate"
    }
    public var reportType: ReportType
    public var reportContent: String?


    
    public init(reportType: ReportType, reportContent: String?) {
        self.reportType = reportType
        self.reportContent = reportContent
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(reportType, forKey: "report_type")
        try container.encodeIfPresent(reportContent, forKey: "report_content")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        reportType = try container.decode(ReportType.self, forKey: "report_type")
        reportContent = try container.decodeIfPresent(String.self, forKey: "report_content")
    }
}

