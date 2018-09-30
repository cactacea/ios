//
// RequestsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class RequestsAPI {
    /**
     Accept a friend request
     
     - parameter id: (path) Friend request Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accept(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        acceptWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Accept a friend request
     
     - parameter id: (path) Friend request Identifier. 
     - returns: Observable<Void>
     */
    open class func accept(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            accept(id: id) { error in
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
     Accept a friend request
     - POST /session/requests/{id}/accept
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Friend request Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func acceptWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/session/requests/{id}/accept"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a friend request to this account
     
     - parameter id: (path) Account Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createFriendRequest(id: Int64, completion: @escaping ((_ data: FriendRequestCreated?,_ error: Error?) -> Void)) {
        createFriendRequestWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create a friend request to this account
     
     - parameter id: (path) Account Identifier. 
     - returns: Observable<FriendRequestCreated>
     */
    open class func createFriendRequest(id: Int64) -> Observable<FriendRequestCreated> {
        return Observable.create { observer -> Disposable in
            createFriendRequest(id: id) { data, error in
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
     Create a friend request to this account
     - POST /accounts/{id}/requests
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "id" : 0.80082819046101150206595775671303272247314453125
}}]
     
     - parameter id: (path) Account Identifier. 

     - returns: RequestBuilder<FriendRequestCreated> 
     */
    open class func createFriendRequestWithRequestBuilder(id: Int64) -> RequestBuilder<FriendRequestCreated> {
        var path = "/accounts/{id}/requests"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<FriendRequestCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Remove a friend request to this account
     
     - parameter id: (path) Account identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteRequest(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteRequestWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Remove a friend request to this account
     
     - parameter id: (path) Account identifier. 
     - returns: Observable<Void>
     */
    open class func deleteRequest(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteRequest(id: id) { error in
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
     Remove a friend request to this account
     - DELETE /accounts/{id}/requests
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Account identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteRequestWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/accounts/{id}/requests"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get friend requests list session account created or received
     
     - parameter received: (query) Filters friend requests which you have received or sent. 
     - parameter since: (query)  (optional)
     - parameter offset: (query) The offset of friend request. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of friend request returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findSessionFriendRequests(received: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [FriendRequest]?,_ error: Error?) -> Void)) {
        findSessionFriendRequestsWithRequestBuilder(received: received, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get friend requests list session account created or received
     
     - parameter received: (query) Filters friend requests which you have received or sent. 
     - parameter since: (query)  (optional)
     - parameter offset: (query) The offset of friend request. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of friend request returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[FriendRequest]>
     */
    open class func findSessionFriendRequests(received: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[FriendRequest]> {
        return Observable.create { observer -> Disposable in
            findSessionFriendRequests(received: received, since: since, offset: offset, count: count) { data, error in
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
     Get friend requests list session account created or received
     - GET /session/requests
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
  "next" : 1,
  "requestedAt" : 6,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "account" : {
    "birthday" : 5.63737665663332876420099637471139430999755859375,
    "next" : 7,
    "follower" : true,
    "followCount" : 6.02745618307040320615897144307382404804229736328125,
    "friendCount" : 5.962133916683182377482808078639209270477294921875,
    "accountName" : "accountName",
    "displayName" : "displayName",
    "joinedAt" : 2.3021358869347654518833223846741020679473876953125,
    "bio" : "bio",
    "mute" : true,
    "follow" : true,
    "friendRequestInProgress" : true,
    "web" : "web",
    "friend" : true,
    "location" : "location",
    "id" : 0.80082819046101150206595775671303272247314453125,
    "profileImageUrl" : "profileImageUrl",
    "followerCount" : 1.46581298050294517310021547018550336360931396484375
  },
  "requestStatus" : "noResponded"
}, {
  "next" : 1,
  "requestedAt" : 6,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "account" : {
    "birthday" : 5.63737665663332876420099637471139430999755859375,
    "next" : 7,
    "follower" : true,
    "followCount" : 6.02745618307040320615897144307382404804229736328125,
    "friendCount" : 5.962133916683182377482808078639209270477294921875,
    "accountName" : "accountName",
    "displayName" : "displayName",
    "joinedAt" : 2.3021358869347654518833223846741020679473876953125,
    "bio" : "bio",
    "mute" : true,
    "follow" : true,
    "friendRequestInProgress" : true,
    "web" : "web",
    "friend" : true,
    "location" : "location",
    "id" : 0.80082819046101150206595775671303272247314453125,
    "profileImageUrl" : "profileImageUrl",
    "followerCount" : 1.46581298050294517310021547018550336360931396484375
  },
  "requestStatus" : "noResponded"
} ]}]
     
     - parameter received: (query) Filters friend requests which you have received or sent. 
     - parameter since: (query)  (optional)
     - parameter offset: (query) The offset of friend request. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of friend request returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[FriendRequest]> 
     */
    open class func findSessionFriendRequestsWithRequestBuilder(received: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[FriendRequest]> {
        let path = "/session/requests"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "since": since, 
            "offset": offset, 
            "count": count, 
            "received": received
        ])
        

        let requestBuilder: RequestBuilder<[FriendRequest]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Reject a friend request
     
     - parameter id: (path) Friend request Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func reject(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        rejectWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Reject a friend request
     
     - parameter id: (path) Friend request Identifier. 
     - returns: Observable<Void>
     */
    open class func reject(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            reject(id: id) { error in
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
     Reject a friend request
     - POST /session/requests/{id}/reject
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Friend request Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func rejectWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/session/requests/{id}/reject"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
