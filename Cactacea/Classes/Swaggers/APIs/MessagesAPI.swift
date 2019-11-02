//
// MessagesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class MessagesAPI {
    /**
     Delete messages form a channel
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMessage(body: DeleteMessagesBody, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteMessageWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Delete messages form a channel
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func deleteMessage(body: DeleteMessagesBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteMessage(body: body) { error in
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
     Delete messages form a channel
     - DELETE /messages
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteMessageWithRequestBuilder(body: DeleteMessagesBody) -> RequestBuilder<Void> {
        let path = "/messages"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Search messages
     
     - parameter id: (query) Channel identifier. 
     - parameter ascending: (query) Order by posted time. 
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findMessages(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Message]?,_ error: Error?) -> Void)) {
        findMessagesWithRequestBuilder(id: id, ascending: ascending, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Search messages
     
     - parameter id: (query) Channel identifier. 
     - parameter ascending: (query) Order by posted time. 
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Message]>
     */
    open class func findMessages(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Message]> {
        return Observable.create { observer -> Disposable in
            findMessages(id: id, ascending: ascending, since: since, offset: offset, count: count) { data, error in
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
     Search messages
     - GET /messages
     - examples: [{contentType=application/json, example=[ {
  "next" : 7,
  "unread" : true,
  "rejected" : true,
  "readUserCount" : 5,
  "medium" : {
    "size" : 5,
    "rejected" : true,
    "width" : 1,
    "mediumType" : "image",
    "warning" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "uri" : "uri",
    "height" : 5,
    "thumbnailUrl" : "thumbnailUrl"
  },
  "message" : "message",
  "messageType" : "text",
  "userCount" : 5,
  "postedAt" : 2,
  "warning" : true,
  "id" : 6.02745618307040320615897144307382404804229736328125,
  "user" : {
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
  },
  "channelId" : 1.46581298050294517310021547018550336360931396484375
}, {
  "next" : 7,
  "unread" : true,
  "rejected" : true,
  "readUserCount" : 5,
  "medium" : {
    "size" : 5,
    "rejected" : true,
    "width" : 1,
    "mediumType" : "image",
    "warning" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "uri" : "uri",
    "height" : 5,
    "thumbnailUrl" : "thumbnailUrl"
  },
  "message" : "message",
  "messageType" : "text",
  "userCount" : 5,
  "postedAt" : 2,
  "warning" : true,
  "id" : 6.02745618307040320615897144307382404804229736328125,
  "user" : {
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
  },
  "channelId" : 1.46581298050294517310021547018550336360931396484375
} ]}]
     
     - parameter id: (query) Channel identifier. 
     - parameter ascending: (query) Order by posted time. 
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Message]> 
     */
    open class func findMessagesWithRequestBuilder(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Message]> {
        let path = "/messages"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "id": id, 
            "since": since, 
            "offset": offset, 
            "count": count, 
            "ascending": ascending
        ])
        

        let requestBuilder: RequestBuilder<[Message]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Send a medium to a channel
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postMedium(body: PostMediumBody, completion: @escaping ((_ data: Message?,_ error: Error?) -> Void)) {
        postMediumWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Send a medium to a channel
     
     - parameter body: (body)  
     - returns: Observable<Message>
     */
    open class func postMedium(body: PostMediumBody) -> Observable<Message> {
        return Observable.create { observer -> Disposable in
            postMedium(body: body) { data, error in
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
     Send a medium to a channel
     - POST /messages/medium
     - examples: [{contentType=application/json, example={
  "next" : 7,
  "unread" : true,
  "rejected" : true,
  "readUserCount" : 5,
  "medium" : {
    "size" : 5,
    "rejected" : true,
    "width" : 1,
    "mediumType" : "image",
    "warning" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "uri" : "uri",
    "height" : 5,
    "thumbnailUrl" : "thumbnailUrl"
  },
  "message" : "message",
  "messageType" : "text",
  "userCount" : 5,
  "postedAt" : 2,
  "warning" : true,
  "id" : 6.02745618307040320615897144307382404804229736328125,
  "user" : {
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
  },
  "channelId" : 1.46581298050294517310021547018550336360931396484375
}}]
     
     - parameter body: (body)  

     - returns: RequestBuilder<Message> 
     */
    open class func postMediumWithRequestBuilder(body: PostMediumBody) -> RequestBuilder<Message> {
        let path = "/messages/medium"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Message>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Send a text to a channel
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postText(body: PostTextBody, completion: @escaping ((_ data: Message?,_ error: Error?) -> Void)) {
        postTextWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Send a text to a channel
     
     - parameter body: (body)  
     - returns: Observable<Message>
     */
    open class func postText(body: PostTextBody) -> Observable<Message> {
        return Observable.create { observer -> Disposable in
            postText(body: body) { data, error in
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
     Send a text to a channel
     - POST /messages/text
     - examples: [{contentType=application/json, example={
  "next" : 7,
  "unread" : true,
  "rejected" : true,
  "readUserCount" : 5,
  "medium" : {
    "size" : 5,
    "rejected" : true,
    "width" : 1,
    "mediumType" : "image",
    "warning" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "uri" : "uri",
    "height" : 5,
    "thumbnailUrl" : "thumbnailUrl"
  },
  "message" : "message",
  "messageType" : "text",
  "userCount" : 5,
  "postedAt" : 2,
  "warning" : true,
  "id" : 6.02745618307040320615897144307382404804229736328125,
  "user" : {
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
  },
  "channelId" : 1.46581298050294517310021547018550336360931396484375
}}]
     
     - parameter body: (body)  

     - returns: RequestBuilder<Message> 
     */
    open class func postTextWithRequestBuilder(body: PostTextBody) -> RequestBuilder<Message> {
        let path = "/messages/text"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Message>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
