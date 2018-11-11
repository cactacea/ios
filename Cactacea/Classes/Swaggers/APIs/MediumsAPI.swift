//
// MediumsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class MediumsAPI {
    /**
     Delete a medium
     
     - parameter id: (path) Medium identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMedium(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteMediumWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Delete a medium
     
     - parameter id: (path) Medium identifier. 
     - returns: Observable<Void>
     */
    open class func deleteMedium(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteMedium(id: id) { error in
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
     Delete a medium
     - DELETE /mediums/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Medium identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteMediumWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/mediums/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Upload a medium
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func uploadMedium(completion: @escaping ((_ data: MediumCreated?,_ error: Error?) -> Void)) {
        uploadMediumWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Upload a medium
     
     - returns: Observable<MediumCreated>
     */
    open class func uploadMedium() -> Observable<MediumCreated> {
        return Observable.create { observer -> Disposable in
            uploadMedium() { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Upload a medium
     - POST /mediums
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "id" : 0.80082819046101150206595775671303272247314453125,
  "uri" : "uri"
}}]

     - returns: RequestBuilder<MediumCreated> 
     */
    open class func uploadMediumWithRequestBuilder() -> RequestBuilder<MediumCreated> {
        let path = "/mediums"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<MediumCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}