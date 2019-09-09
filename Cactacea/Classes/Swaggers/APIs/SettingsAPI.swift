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
    open class func findPushNotification(completion: @escaping ((_ data: PushNotificationSetting?,_ error: Error?) -> Void)) {
        findPushNotificationWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get push notification settings
     
     - returns: Observable<PushNotificationSetting>
     */
    open class func findPushNotification() -> Observable<PushNotificationSetting> {
        return Observable.create { observer -> Disposable in
            findPushNotification() { data, error in
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
     - GET /session/push/notification
     - examples: [{contentType=application/json, example={
  "feed" : true,
  "channelMessage" : true,
  "invitation" : true,
  "showMessage" : true,
  "comment" : true,
  "friendRequest" : true,
  "message" : true
}}]

     - returns: RequestBuilder<PushNotificationSetting> 
     */
    open class func findPushNotificationWithRequestBuilder() -> RequestBuilder<PushNotificationSetting> {
        let path = "/session/push/notification"
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
    open class func updateDeviceStatus(body: PutDeviceBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updateDeviceStatusWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update device status
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updateDeviceStatus(body: PutDeviceBody) -> Observable<Void> {
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
     - PUT /session/device
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateDeviceStatusWithRequestBuilder(body: PutDeviceBody) -> RequestBuilder<Void> {
        let path = "/session/device"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update ths push notification settings
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updatePushNotification(body: PutNotificationSettingBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updatePushNotificationWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update ths push notification settings
     
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updatePushNotification(body: PutNotificationSettingBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updatePushNotification(body: body) { error in
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
     - PUT /session/push/notification
     
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updatePushNotificationWithRequestBuilder(body: PutNotificationSettingBody) -> RequestBuilder<Void> {
        let path = "/session/push/notification"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
