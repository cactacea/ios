//
// FollowsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class FollowsAPI {
    /**
     Get accounts list this account is followed by
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters followers which started on since or later. (optional)
     - parameter offset: (query) The offset of followers. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of followers returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findAccountFollowers(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Account]?,_ error: Error?) -> Void)) {
        findAccountFollowersWithRequestBuilder(id: id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get accounts list this account is followed by
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters followers which started on since or later. (optional)
     - parameter offset: (query) The offset of followers. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of followers returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Account]>
     */
    open class func findAccountFollowers(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Account]> {
        return Observable.create { observer -> Disposable in
            findAccountFollowers(id: id, since: since, offset: offset, count: count) { data, error in
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
     Get accounts list this account is followed by
     - GET /accounts/{id}/followers
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
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
}, {
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
} ]}]
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters followers which started on since or later. (optional)
     - parameter offset: (query) The offset of followers. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of followers returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Account]> 
     */
    open class func findAccountFollowersWithRequestBuilder(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Account]> {
        var path = "/accounts/{id}/followers"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[Account]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get accounts list this user followed
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters follower which started on since or later. (optional)
     - parameter offset: (query) The offset of follower. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of follower returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findFollows(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Account]?,_ error: Error?) -> Void)) {
        findFollowsWithRequestBuilder(id: id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get accounts list this user followed
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters follower which started on since or later. (optional)
     - parameter offset: (query) The offset of follower. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of follower returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Account]>
     */
    open class func findFollows(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Account]> {
        return Observable.create { observer -> Disposable in
            findFollows(id: id, since: since, offset: offset, count: count) { data, error in
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
     Get accounts list this user followed
     - GET /accounts/{id}/follows
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
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
}, {
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
} ]}]
     
     - parameter id: (path) Account Identifier. 
     - parameter since: (query) Filters follower which started on since or later. (optional)
     - parameter offset: (query) The offset of follower. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of follower returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Account]> 
     */
    open class func findFollowsWithRequestBuilder(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Account]> {
        var path = "/accounts/{id}/follows"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[Account]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Follow this account
     
     - parameter id: (path) Account Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func follow(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        followWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Follow this account
     
     - parameter id: (path) Account Identifier. 
     - returns: Observable<Void>
     */
    open class func follow(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            follow(id: id) { error in
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
     Follow this account
     - POST /accounts/{id}/follows
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Account Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func followWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/accounts/{id}/follows"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     UnFollow this account
     
     - parameter id: (path) Account Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func unfollow(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        unfollowWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     UnFollow this account
     
     - parameter id: (path) Account Identifier. 
     - returns: Observable<Void>
     */
    open class func unfollow(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            unfollow(id: id) { error in
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
     UnFollow this account
     - DELETE /accounts/{id}/follows
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Account Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func unfollowWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/accounts/{id}/follows"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
