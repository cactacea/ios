//
// TweetLikesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class TweetLikesAPI {
    /**
     Get users list who set a like to a tweet
     
     - parameter id: (path) Tweet identifier. 
     - parameter since: (query) Filters users which started on since or later. (optional)
     - parameter offset: (query) The offset of users. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of users returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findUsersLikedTweet(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [User]?,_ error: Error?) -> Void)) {
        findUsersLikedTweetWithRequestBuilder(id: id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get users list who set a like to a tweet
     
     - parameter id: (path) Tweet identifier. 
     - parameter since: (query) Filters users which started on since or later. (optional)
     - parameter offset: (query) The offset of users. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of users returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[User]>
     */
    open class func findUsersLikedTweet(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[User]> {
        return Observable.create { observer -> Disposable in
            findUsersLikedTweet(id: id, since: since, offset: offset, count: count) { data, error in
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
     Get users list who set a like to a tweet
     - GET /tweets/{id}/likes
     - examples: [{contentType=application/json, example=[ {
  "birthday" : 2.3021358869347654518833223846741020679473876953125,
  "next" : 3,
  "followCount" : 6,
  "friendCount" : 5,
  "userStatus" : "normally",
  "displayName" : "displayName",
  "joinedAt" : 7.061401241503109105224211816675961017608642578125,
  "tweetCount" : 5,
  "bio" : "bio",
  "signedOutAt" : 9.301444243932575517419536481611430644989013671875,
  "userName" : "userName",
  "follow" : true,
  "friendRequestInProgress" : true,
  "blocked" : true,
  "web" : "web",
  "isFriend" : true,
  "location" : "location",
  "id" : 0.80082819046101150206595775671303272247314453125,
  "isFollower" : true,
  "profileImageUrl" : "profileImageUrl",
  "followerCount" : 1,
  "muted" : true
}, {
  "birthday" : 2.3021358869347654518833223846741020679473876953125,
  "next" : 3,
  "followCount" : 6,
  "friendCount" : 5,
  "userStatus" : "normally",
  "displayName" : "displayName",
  "joinedAt" : 7.061401241503109105224211816675961017608642578125,
  "tweetCount" : 5,
  "bio" : "bio",
  "signedOutAt" : 9.301444243932575517419536481611430644989013671875,
  "userName" : "userName",
  "follow" : true,
  "friendRequestInProgress" : true,
  "blocked" : true,
  "web" : "web",
  "isFriend" : true,
  "location" : "location",
  "id" : 0.80082819046101150206595775671303272247314453125,
  "isFollower" : true,
  "profileImageUrl" : "profileImageUrl",
  "followerCount" : 1,
  "muted" : true
} ]}]
     
     - parameter id: (path) Tweet identifier. 
     - parameter since: (query) Filters users which started on since or later. (optional)
     - parameter offset: (query) The offset of users. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of users returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[User]> 
     */
    open class func findUsersLikedTweetWithRequestBuilder(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[User]> {
        var path = "/tweets/{id}/likes"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[User]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Set a like on a tweet
     
     - parameter id: (path) Tweet identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func likeTweet(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        likeTweetWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Set a like on a tweet
     
     - parameter id: (path) Tweet identifier. 
     - returns: Observable<Void>
     */
    open class func likeTweet(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            likeTweet(id: id) { error in
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
     Set a like on a tweet
     - POST /tweets/{id}/likes
     
     - parameter id: (path) Tweet identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func likeTweetWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/tweets/{id}/likes"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Remove a like on a tweet
     
     - parameter id: (path) Tweet identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func unlikeTweet(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        unlikeTweetWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Remove a like on a tweet
     
     - parameter id: (path) Tweet identifier. 
     - returns: Observable<Void>
     */
    open class func unlikeTweet(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            unlikeTweet(id: id) { error in
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
     Remove a like on a tweet
     - DELETE /tweets/{id}/likes
     
     - parameter id: (path) Tweet identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func unlikeTweetWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/tweets/{id}/likes"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
