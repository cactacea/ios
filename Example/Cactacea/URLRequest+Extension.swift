//
//  URLRequest+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/09/12.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import Cactacea

extension URLRequest {
    
    static func request(url: String) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.setValue(CactaceaAPI.customHeaders["x-api-key"], forHTTPHeaderField: "x-api-key")
        urlRequest.setValue(CactaceaAPI.customHeaders["Authorization"], forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
}
