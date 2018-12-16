//
//  RequestBuilder.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import Alamofire
import Cactacea

open class CactaceaRequestBuilder<T>: AlamofireRequestBuilder<T> {

    override open func createSessionManager() -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = buildHeaders()
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return Alamofire.SessionManager(configuration: configuration)
    }

}

class CactaceaRequestBuilderFactory: RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        return CactaceaRequestBuilder<T>.self
    }
    
    func getBuilder<T:Decodable>() -> RequestBuilder<T>.Type {
        return CactaceaRequestBuilder<T>.self
    }
}
