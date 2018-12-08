//
//  Session.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Cactacea

class Session {
    
    static var authentication: Authentication? {
        didSet {
            CactaceaAPI.customHeaders["X-AUTHORIZATION"] = authentication?.accessToken
        }
    }
    
    static func request(url: String) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.setValue(CactaceaAPI.customHeaders["X-API-KEY"], forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue(CactaceaAPI.customHeaders["X-AUTHORIZATION"], forHTTPHeaderField: "X-AUTHORIZATION")
        return urlRequest
    }

}
