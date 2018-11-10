//
// SettingsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class SettingsAPI {
    /**
     Get push notification settings
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findSessionPushNotificationSettings(completion: @escaping ((_ data: PushNotificationSetting?,_ error: Error?) -> Void)) {
        findSessionPushNotificationSettingsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get push notification settings
     
     - returns: Observable<PushNotificationSetting>
     */
    open class func findSessionPushNotificationSettings() -> Observable<PushNotificationSetting> {
        return Observable.create { observer -> Disposable in
            findSessionPushNotificationSettings() { data, error in
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
     Get push notification settings
     - GET /session/push_notification
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "directMessage" : true,
  "groupInvitation" : true,
  "showMessage" : true,
  "followerFeed" : true,
  "feedComment" : true,
  "groupMessage" : true
}}]

     - returns: RequestBuilder<PushNotificationSetting> 
     */
    open class func findSessionPushNotificationSettingsWithRequestBuilder() -> RequestBuilder<PushNotificationSetting> {
        let path = "/session/push_notification"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<PushNotificationSetting>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update device status
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateSessionDeviceStatus(body: PostActiveStatusBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updateSessionDeviceStatusWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update device status
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updateSessionDeviceStatus(body: PostActiveStatusBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateSessionDeviceStatus(body: body) { error in
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
     Update device status
     - POST /session/status
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateSessionDeviceStatusWithRequestBuilder(body: PostActiveStatusBody) -> RequestBuilder<Void> {
        let path = "/session/status"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update ths push notification settings
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateSessionPushNotificationSettings(completion: @escaping ((_ error: Error?) -> Void)) {
        updateSessionPushNotificationSettingsWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update ths push notification settings
     
     - returns: Observable<Void>
     */
    open class func updateSessionPushNotificationSettings() -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateSessionPushNotificationSettings() { error in
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
     Update ths push notification settings
     - PUT /session/push_notification
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth

     - returns: RequestBuilder<Void> 
     */
    open class func updateSessionPushNotificationSettingsWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/session/push_notification"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update device push token
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateSessionPushToken(body: PostDevicePushTokenBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updateSessionPushTokenWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update device push token
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updateSessionPushToken(body: PostDevicePushTokenBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateSessionPushToken(body: body) { error in
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
     Update device push token
     - POST /session/push_token
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateSessionPushTokenWithRequestBuilder(body: PostDevicePushTokenBody) -> RequestBuilder<Void> {
        let path = "/session/push_token"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
