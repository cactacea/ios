//
// FeedsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Alamofire
import RxSwift



open class FeedsAPI {
    /**
     Delete a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteFeed(_id: Int64, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteFeedWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Delete a feed
     
     - parameter _id: (path) Feed identifier. 
     - returns: Observable<Void>
     */
    open class func deleteFeed(_id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteFeed(_id: _id) { data, error in
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
     Delete a feed
     - DELETE /feeds/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Feed identifier. 
     - returns: RequestBuilder<Void> 
     */
    open class func deleteFeedWithRequestBuilder(_id: Int64) -> RequestBuilder<Void> {
        var path = "/feeds/{id}"
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
     Get feeds list a account posted
     
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findAccountFeeds(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: Feed?,_ error: Error?) -> Void)) {
        findAccountFeedsWithRequestBuilder(_id: _id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get feeds list a account posted
     
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<Feed>
     */
    open class func findAccountFeeds(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<Feed> {
        return Observable.create { observer -> Disposable in
            findAccountFeeds(_id: _id, since: since, offset: offset, count: count) { data, error in
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
     Get feeds list a account posted
     - GET /accounts/{id}/feeds
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: RequestBuilder<Feed> 
     */
    open class func findAccountFeedsWithRequestBuilder(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<Feed> {
        var path = "/accounts/{id}/feeds"
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

        let requestBuilder: RequestBuilder<Feed>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get account's liked feeds
     
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findAccountLikes(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Feed]?,_ error: Error?) -> Void)) {
        findAccountLikesWithRequestBuilder(_id: _id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get account's liked feeds
     
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Feed]>
     */
    open class func findAccountLikes(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Feed]> {
        return Observable.create { observer -> Disposable in
            findAccountLikes(_id: _id, since: since, offset: offset, count: count) { data, error in
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
     Get account's liked feeds
     - GET /accounts/{id}/likes
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Account Identifier. 
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: RequestBuilder<[Feed]> 
     */
    open class func findAccountLikesWithRequestBuilder(_id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Feed]> {
        var path = "/accounts/{id}/likes"
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

        let requestBuilder: RequestBuilder<[Feed]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get basic information about a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findFeed(_id: Int64, completion: @escaping ((_ data: Feed?,_ error: Error?) -> Void)) {
        findFeedWithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get basic information about a feed
     
     - parameter _id: (path) Feed identifier. 
     - returns: Observable<Feed>
     */
    open class func findFeed(_id: Int64) -> Observable<Feed> {
        return Observable.create { observer -> Disposable in
            findFeed(_id: _id) { data, error in
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
     Get basic information about a feed
     - GET /feeds/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Feed identifier. 
     - returns: RequestBuilder<Feed> 
     */
    open class func findFeedWithRequestBuilder(_id: Int64) -> RequestBuilder<Feed> {
        var path = "/feeds/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Feed>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Search feeds
     
     - parameter getFeedsBody: (body)  
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findFeeds(getFeedsBody: GetFeedsBody, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Feed]?,_ error: Error?) -> Void)) {
        findFeedsWithRequestBuilder(getFeedsBody: getFeedsBody, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Search feeds
     
     - parameter getFeedsBody: (body)  
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Feed]>
     */
    open class func findFeeds(getFeedsBody: GetFeedsBody, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Feed]> {
        return Observable.create { observer -> Disposable in
            findFeeds(getFeedsBody: getFeedsBody, since: since, offset: offset, count: count) { data, error in
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
     Search feeds
     - GET /feeds
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter getFeedsBody: (body)  
     - parameter since: (query) Filters feeds which started on since or later. (optional)
     - parameter offset: (query) The offset of feeds. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of feeds returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: RequestBuilder<[Feed]> 
     */
    open class func findFeedsWithRequestBuilder(getFeedsBody: GetFeedsBody, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Feed]> {
        let path = "/feeds"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: getFeedsBody)

        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "since": since, 
            "offset": offset, 
            "count": count
        ])

        let requestBuilder: RequestBuilder<[Feed]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Post a feed
     
     - parameter postFeedBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postFeed(postFeedBody: PostFeedBody, completion: @escaping ((_ data: FeedCreated?,_ error: Error?) -> Void)) {
        postFeedWithRequestBuilder(postFeedBody: postFeedBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Post a feed
     
     - parameter postFeedBody: (body)  
     - returns: Observable<FeedCreated>
     */
    open class func postFeed(postFeedBody: PostFeedBody) -> Observable<FeedCreated> {
        return Observable.create { observer -> Disposable in
            postFeed(postFeedBody: postFeedBody) { data, error in
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
     Post a feed
     - POST /feeds
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter postFeedBody: (body)  
     - returns: RequestBuilder<FeedCreated> 
     */
    open class func postFeedWithRequestBuilder(postFeedBody: PostFeedBody) -> RequestBuilder<FeedCreated> {
        let path = "/feeds"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: postFeedBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<FeedCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Report a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter postFeedReportBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func reportFeed(_id: Int64, postFeedReportBody: PostFeedReportBody, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        reportFeedWithRequestBuilder(_id: _id, postFeedReportBody: postFeedReportBody).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Report a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter postFeedReportBody: (body)  
     - returns: Observable<Void>
     */
    open class func reportFeed(_id: Int64, postFeedReportBody: PostFeedReportBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            reportFeed(_id: _id, postFeedReportBody: postFeedReportBody) { data, error in
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
     Report a feed
     - POST /feeds/{id}/reports
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Feed identifier. 
     - parameter postFeedReportBody: (body)  
     - returns: RequestBuilder<Void> 
     */
    open class func reportFeedWithRequestBuilder(_id: Int64, postFeedReportBody: PostFeedReportBody) -> RequestBuilder<Void> {
        var path = "/feeds/{id}/reports"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: postFeedReportBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter putFeedBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateFeed(_id: Int64, putFeedBody: PutFeedBody, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        updateFeedWithRequestBuilder(_id: _id, putFeedBody: putFeedBody).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }

    /**
     Update a feed
     
     - parameter _id: (path) Feed identifier. 
     - parameter putFeedBody: (body)  
     - returns: Observable<Void>
     */
    open class func updateFeed(_id: Int64, putFeedBody: PutFeedBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateFeed(_id: _id, putFeedBody: putFeedBody) { data, error in
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
     Update a feed
     - PUT /feeds/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - parameter _id: (path) Feed identifier. 
     - parameter putFeedBody: (body)  
     - returns: RequestBuilder<Void> 
     */
    open class func updateFeedWithRequestBuilder(_id: Int64, putFeedBody: PutFeedBody) -> RequestBuilder<Void> {
        var path = "/feeds/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: putFeedBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}