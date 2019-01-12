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
    open class func findPushNotificationSettings(completion: @escaping ((_ data: PushNotificationSetting?,_ error: Error?) -> Void)) {
        findPushNotificationSettingsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get push notification settings
     
     - returns: Observable<PushNotificationSetting>
     */
    open class func findPushNotificationSettings() -> Observable<PushNotificationSetting> {
        return Observable.create { observer -> Disposable in
            findPushNotificationSettings() { data, error in
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
  "feed" : true,
  "groupInvitation" : true,
  "showMessage" : true,
  "comment" : true,
  "friendRequest" : true,
  "message" : true,
  "groupMessage" : true
}}]

     - returns: RequestBuilder<PushNotificationSetting> 
     */
    open class func findPushNotificationSettingsWithRequestBuilder() -> RequestBuilder<PushNotificationSetting> {
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
    open class func updateDeviceStatus(body: PostActiveStatusBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updateDeviceStatusWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update device status
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updateDeviceStatus(body: PostActiveStatusBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateDeviceStatus(body: body) { error in
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
    open class func updateDeviceStatusWithRequestBuilder(body: PostActiveStatusBody) -> RequestBuilder<Void> {
        let path = "/session/status"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update ths push notification settings
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updatePushNotificationSettings(body: PutNotificationSettingBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updatePushNotificationSettingsWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update ths push notification settings
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updatePushNotificationSettings(body: PutNotificationSettingBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updatePushNotificationSettings(body: body) { error in
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
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updatePushNotificationSettingsWithRequestBuilder(body: PutNotificationSettingBody) -> RequestBuilder<Void> {
        let path = "/session/push_notification"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update device push token
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updatePushToken(body: PostDevicePushTokenBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updatePushTokenWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update device push token
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updatePushToken(body: PostDevicePushTokenBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updatePushToken(body: body) { error in
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
    open class func updatePushTokenWithRequestBuilder(body: PostDevicePushTokenBody) -> RequestBuilder<Void> {
        let path = "/session/push_token"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
