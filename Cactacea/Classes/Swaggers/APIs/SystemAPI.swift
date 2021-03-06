//
// SystemAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class SystemAPI {
    /**
     Health checking
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func ping(completion: @escaping ((_ error: Error?) -> Void)) {
        pingWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Health checking
     
     - returns: Observable<Void>
     */
    open class func ping() -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            ping() { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Health checking
     - GET /ping

     - returns: RequestBuilder<Void> 
     */
    open class func pingWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/ping"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
