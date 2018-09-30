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
     Delete messages form a group
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMessage(body: DeleteMessagesBody, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteMessageWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Delete messages form a group
     
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
     Delete messages form a group
     - DELETE /messages
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
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
     
     - parameter id: (query) Group identifier. 
     - parameter ascending: (query)  
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findMessages(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: Message?,_ error: Error?) -> Void)) {
        findMessagesWithRequestBuilder(id: id, ascending: ascending, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Search messages
     
     - parameter id: (query) Group identifier. 
     - parameter ascending: (query)  
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<Message>
     */
    open class func findMessages(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<Message> {
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
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "contentWarning" : true,
  "readAccountCount" : 5,
  "accountCount" : 1,
  "messageType" : "text",
  "postedAt" : 5,
  "unread" : true,
  "by" : {
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
  "contentDeleted" : true,
  "id" : 6.02745618307040320615897144307382404804229736328125,
  "medium" : {
    "contentWarning" : true,
    "size" : 5,
    "contentDeleted" : true,
    "width" : 1,
    "mediumType" : "image",
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "uri" : "uri",
    "height" : 5,
    "thumbnailUrl" : "thumbnailUrl"
  },
  "message" : "message",
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
  }
}}]
     
     - parameter id: (query) Group identifier. 
     - parameter ascending: (query)  
     - parameter since: (query) Filters messages which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of entries returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<Message> 
     */
    open class func findMessagesWithRequestBuilder(id: Int64, ascending: Bool, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<Message> {
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
        

        let requestBuilder: RequestBuilder<Message>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Post a message to a group
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postMessage(body: PostMessageBody, completion: @escaping ((_ data: MessageCreated?,_ error: Error?) -> Void)) {
        postMessageWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Post a message to a group
     
     - parameter body: (body)  
     - returns: Observable<MessageCreated>
     */
    open class func postMessage(body: PostMessageBody) -> Observable<MessageCreated> {
        return Observable.create { observer -> Disposable in
            postMessage(body: body) { data, error in
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
     Post a message to a group
     - POST /messages
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

     - returns: RequestBuilder<MessageCreated> 
     */
    open class func postMessageWithRequestBuilder(body: PostMessageBody) -> RequestBuilder<MessageCreated> {
        let path = "/messages"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<MessageCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
