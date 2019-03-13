//
// CommentsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class CommentsAPI {
    /**
     Remove a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func delete(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Remove a comment
     
     - parameter id: (path) Comment Identifier. 
     - returns: Observable<Void>
     */
    open class func delete(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            delete(id: id) { error in
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
     Remove a comment
     - DELETE /comments/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Comment Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/comments/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get basic information about a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findComment(id: Int64, completion: @escaping ((_ data: Comment?,_ error: Error?) -> Void)) {
        findCommentWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get basic information about a comment
     
     - parameter id: (path) Comment Identifier. 
     - returns: Observable<Comment>
     */
    open class func findComment(id: Int64) -> Observable<Comment> {
        return Observable.create { observer -> Disposable in
            findComment(id: id) { data, error in
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
     Get basic information about a comment
     - GET /comments/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "next" : 5.63737665663332876420099637471139430999755859375,
  "contentWarning" : true,
  "postedAt" : 5,
  "contentDeleted" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "likeCount" : 1,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "account" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 9.301444243932575517419536481611430644989013671875,
    "friendCount" : 5,
    "accountName" : "accountName",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
    "bio" : "bio",
    "followingCount" : 6,
    "friendRequestInProgress" : true,
    "muting" : true,
    "web" : "web",
    "blocking" : true,
    "following" : true,
    "isFriend" : true,
    "location" : "location",
    "id" : 0.80082819046101150206595775671303272247314453125,
    "isFollower" : true,
    "profileImageUrl" : "profileImageUrl",
    "followerCount" : 1
  }
}}]
     
     - parameter id: (path) Comment Identifier. 

     - returns: RequestBuilder<Comment> 
     */
    open class func findCommentWithRequestBuilder(id: Int64) -> RequestBuilder<Comment> {
        var path = "/comments/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Comment>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Search comments
     
     - parameter id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findComments(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Comment]?,_ error: Error?) -> Void)) {
        findCommentsWithRequestBuilder(id: id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Search comments
     
     - parameter id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Comment]>
     */
    open class func findComments(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Comment]> {
        return Observable.create { observer -> Disposable in
            findComments(id: id, since: since, offset: offset, count: count) { data, error in
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
     Search comments
     - GET /comments
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
  "next" : 5.63737665663332876420099637471139430999755859375,
  "contentWarning" : true,
  "postedAt" : 5,
  "contentDeleted" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "likeCount" : 1,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "account" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 9.301444243932575517419536481611430644989013671875,
    "friendCount" : 5,
    "accountName" : "accountName",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
    "bio" : "bio",
    "followingCount" : 6,
    "friendRequestInProgress" : true,
    "muting" : true,
    "web" : "web",
    "blocking" : true,
    "following" : true,
    "isFriend" : true,
    "location" : "location",
    "id" : 0.80082819046101150206595775671303272247314453125,
    "isFollower" : true,
    "profileImageUrl" : "profileImageUrl",
    "followerCount" : 1
  }
}, {
  "next" : 5.63737665663332876420099637471139430999755859375,
  "contentWarning" : true,
  "postedAt" : 5,
  "contentDeleted" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "likeCount" : 1,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "account" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 9.301444243932575517419536481611430644989013671875,
    "friendCount" : 5,
    "accountName" : "accountName",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
    "bio" : "bio",
    "followingCount" : 6,
    "friendRequestInProgress" : true,
    "muting" : true,
    "web" : "web",
    "blocking" : true,
    "following" : true,
    "isFriend" : true,
    "location" : "location",
    "id" : 0.80082819046101150206595775671303272247314453125,
    "isFollower" : true,
    "profileImageUrl" : "profileImageUrl",
    "followerCount" : 1
  }
} ]}]
     
     - parameter id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Comment]> 
     */
    open class func findCommentsWithRequestBuilder(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Comment]> {
        let path = "/comments"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "id": id, 
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[Comment]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a comment on a feed
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func post(body: PostCommentBody, completion: @escaping ((_ data: CommentCreated?,_ error: Error?) -> Void)) {
        postWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create a comment on a feed
     
     - parameter body: (body)  
     - returns: Observable<CommentCreated>
     */
    open class func post(body: PostCommentBody) -> Observable<CommentCreated> {
        return Observable.create { observer -> Disposable in
            post(body: body) { data, error in
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
     Create a comment on a feed
     - POST /comments
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "id" : 0.80082819046101150206595775671303272247314453125
}}]
     
     - parameter body: (body)  

     - returns: RequestBuilder<CommentCreated> 
     */
    open class func postWithRequestBuilder(body: PostCommentBody) -> RequestBuilder<CommentCreated> {
        let path = "/comments"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<CommentCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Report a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func report(id: Int64, body: PostCommentReportBody, completion: @escaping ((_ error: Error?) -> Void)) {
        reportWithRequestBuilder(id: id, body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Report a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func report(id: Int64, body: PostCommentReportBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            report(id: id, body: body) { error in
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
     Report a comment
     - POST /comments/{id}/reports
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Comment Identifier. 
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func reportWithRequestBuilder(id: Int64, body: PostCommentReportBody) -> RequestBuilder<Void> {
        var path = "/comments/{id}/reports"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
