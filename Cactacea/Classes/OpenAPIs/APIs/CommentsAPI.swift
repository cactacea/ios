//
// CommentsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Alamofire
import RxSwift



open class CommentsAPI {
    /**
     Remove a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteComment(_id: Int64, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteCommentWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Remove a comment
     
     - parameter _id: (path) Comment Identifier. 
     - returns: Observable<Void>
     */
    open class func deleteComment(_id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteComment(_id: _id) { data, error in
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
     Remove a comment
     - DELETE /comments/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Comment Identifier. 
     - returns: RequestBuilder<Void> 
     */
    open class func deleteCommentWithRequestBuilder(_id: Int64) -> RequestBuilder<Void> {
        var path = "/comments/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get basic information about a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findComment(_id: Int64, completion: @escaping ((_ data: Comment?,_ error: Error?) -> Void)) {
        findCommentWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get basic information about a comment
     
     - parameter _id: (path) Comment Identifier. 
     - returns: Observable<Comment>
     */
    open class func findComment(_id: Int64) -> Observable<Comment> {
        return Observable.create { observer -> Disposable in
            findComment(_id: _id) { data, error in
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
     - parameter _id: (path) Comment Identifier. 
     - returns: RequestBuilder<Comment> 
     */
    open class func findCommentWithRequestBuilder(_id: Int64) -> RequestBuilder<Comment> {
        var path = "/comments/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Comment>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get accounts list who liked on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findCommentLikes(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Account]?,_ error: Error?) -> Void)) {
        findCommentLikesWithRequestBuilder(_id: _id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get accounts list who liked on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Account]>
     */
    open class func findCommentLikes(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Account]> {
        return Observable.create { observer -> Disposable in
            findCommentLikes(_id: _id, since: since, offset: offset, count: count) { data, error in
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
     Get accounts list who liked on a comment
     - GET /comments/{id}/likes
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Comment Identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: RequestBuilder<[Account]> 
     */
    open class func findCommentLikesWithRequestBuilder(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Account]> {
        var path = "/comments/{id}/likes"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "since": since, 
            "offset": offset, 
            "count": count
        ])

        let requestBuilder: RequestBuilder<[Account]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Search comments
     
     - parameter _id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findComments(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Comment]?,_ error: Error?) -> Void)) {
        findCommentsWithRequestBuilder(_id: _id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Search comments
     
     - parameter _id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Comment]>
     */
    open class func findComments(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Comment]> {
        return Observable.create { observer -> Disposable in
            findComments(_id: _id, since: since, offset: offset, count: count) { data, error in
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
     - parameter _id: (query) Feed identifier. 
     - parameter since: (query) Filters comments which started on since or later. (optional)
     - parameter offset: (query) The offset of comments. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of comments returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: RequestBuilder<[Comment]> 
     */
    open class func findCommentsWithRequestBuilder(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Comment]> {
        let path = "/comments"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "id": _id, 
            "since": since, 
            "offset": offset, 
            "count": count
        ])

        let requestBuilder: RequestBuilder<[Comment]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Set a like on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func likeComment(_id: Int64, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        likeCommentWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Set a like on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - returns: Observable<Void>
     */
    open class func likeComment(_id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            likeComment(_id: _id) { data, error in
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
     Set a like on a comment
     - POST /comments/{id}/likes
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Comment Identifier. 
     - returns: RequestBuilder<Void> 
     */
    open class func likeCommentWithRequestBuilder(_id: Int64) -> RequestBuilder<Void> {
        var path = "/comments/{id}/likes"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a comment on a feed
     
     - parameter postCommentBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postComment(postCommentBody: PostCommentBody, completion: @escaping ((_ data: CommentCreated?,_ error: Error?) -> Void)) {
        postCommentWithRequestBuilder(postCommentBody: postCommentBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Create a comment on a feed
     
     - parameter postCommentBody: (body)  
     - returns: Observable<CommentCreated>
     */
    open class func postComment(postCommentBody: PostCommentBody) -> Observable<CommentCreated> {
        return Observable.create { observer -> Disposable in
            postComment(postCommentBody: postCommentBody) { data, error in
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
     - parameter postCommentBody: (body)  
     - returns: RequestBuilder<CommentCreated> 
     */
    open class func postCommentWithRequestBuilder(postCommentBody: PostCommentBody) -> RequestBuilder<CommentCreated> {
        let path = "/comments"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: postCommentBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<CommentCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Report a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter postCommentReportBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func reportComment(_id: Int64, postCommentReportBody: PostCommentReportBody, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        reportCommentWithRequestBuilder(_id: _id, postCommentReportBody: postCommentReportBody).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Report a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter postCommentReportBody: (body)  
     - returns: Observable<Void>
     */
    open class func reportComment(_id: Int64, postCommentReportBody: PostCommentReportBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            reportComment(_id: _id, postCommentReportBody: postCommentReportBody) { data, error in
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
     Report a comment
     - POST /comments/{id}/reports
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Comment Identifier. 
     - parameter postCommentReportBody: (body)  
     - returns: RequestBuilder<Void> 
     */
    open class func reportCommentWithRequestBuilder(_id: Int64, postCommentReportBody: PostCommentReportBody) -> RequestBuilder<Void> {
        var path = "/comments/{id}/reports"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: postCommentReportBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Remove a like on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func unlikeComment(_id: Int64, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        unlikeCommentWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Remove a like on a comment
     
     - parameter _id: (path) Comment Identifier. 
     - returns: Observable<Void>
     */
    open class func unlikeComment(_id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            unlikeComment(_id: _id) { data, error in
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
     Remove a like on a comment
     - DELETE /comments/{id}/likes
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Comment Identifier. 
     - returns: RequestBuilder<Void> 
     */
    open class func unlikeCommentWithRequestBuilder(_id: Int64) -> RequestBuilder<Void> {
        var path = "/comments/{id}/likes"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}