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
     Delete a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteComment(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteCommentWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Delete a comment
     
     - parameter id: (path) Comment Identifier. 
     - returns: Observable<Void>
     */
    open class func deleteComment(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteComment(id: id) { error in
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
     Delete a comment
     - DELETE /comments/{id}
     
     - parameter id: (path) Comment Identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteCommentWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
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
     - examples: [{contentType=application/json, example={
  "next" : 2,
  "postedAt" : 5,
  "feedId" : 1.46581298050294517310021547018550336360931396484375,
  "rejected" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "warning" : true,
  "likeCount" : 5,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "user" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 3,
    "followCount" : 6,
    "friendCount" : 5,
    "userStatus" : "normally",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
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
     - examples: [{contentType=application/json, example=[ {
  "next" : 2,
  "postedAt" : 5,
  "feedId" : 1.46581298050294517310021547018550336360931396484375,
  "rejected" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "warning" : true,
  "likeCount" : 5,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "user" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 3,
    "followCount" : 6,
    "friendCount" : 5,
    "userStatus" : "normally",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
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
  }
}, {
  "next" : 2,
  "postedAt" : 5,
  "feedId" : 1.46581298050294517310021547018550336360931396484375,
  "rejected" : true,
  "replyId" : 6.02745618307040320615897144307382404804229736328125,
  "warning" : true,
  "likeCount" : 5,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : "message",
  "user" : {
    "birthday" : 2.3021358869347654518833223846741020679473876953125,
    "next" : 3,
    "followCount" : 6,
    "friendCount" : 5,
    "userStatus" : "normally",
    "displayName" : "displayName",
    "joinedAt" : 7.061401241503109105224211816675961017608642578125,
    "feedCount" : 5,
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
    open class func postComment(body: PostCommentBody, completion: @escaping ((_ data: CommentCreated?,_ error: Error?) -> Void)) {
        postCommentWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create a comment on a feed
     
     - parameter body: (body)  
     - returns: Observable<CommentCreated>
     */
    open class func postComment(body: PostCommentBody) -> Observable<CommentCreated> {
        return Observable.create { observer -> Disposable in
            postComment(body: body) { data, error in
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
     - examples: [{contentType=application/json, example={
  "id" : 0.80082819046101150206595775671303272247314453125
}}]
     
     - parameter body: (body)  

     - returns: RequestBuilder<CommentCreated> 
     */
    open class func postCommentWithRequestBuilder(body: PostCommentBody) -> RequestBuilder<CommentCreated> {
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
    open class func reportComment(id: Int64, body: PostCommentReportBody, completion: @escaping ((_ error: Error?) -> Void)) {
        reportCommentWithRequestBuilder(id: id, body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Report a comment
     
     - parameter id: (path) Comment Identifier. 
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func reportComment(id: Int64, body: PostCommentReportBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            reportComment(id: id, body: body) { error in
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
     
     - parameter id: (path) Comment Identifier. 
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func reportCommentWithRequestBuilder(id: Int64, body: PostCommentReportBody) -> RequestBuilder<Void> {
        var path = "/comments/{id}/reports"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
