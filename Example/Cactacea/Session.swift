//
//  Session.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Cactacea

class Session {
    
    static var accessToken: String?

    static var user: User? {
        didSet {
//            CactaceaAPI.customHeaders["X-AUTHORIZATION"] = user?.accessToken
        }
    }
    
    static var playerId: String? {
        didSet {
            if let _ = Session.user {
                self.updateToken()
            }
        }
    }

    static var uuid: String = ""

    static func updateToken() {
        if let _ = Session.user {
            let body = PutDeviceBody(status: PutDeviceBody.Status.active, udid: Session.uuid, pushToken: self.playerId)
            SettingsAPI.updateDeviceStatus(body: body) { (error) in
                if let error = error {
                    Session.showError(error)
                }
            }
        }
    }
    
    static func request(url: String) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.setValue(CactaceaAPI.customHeaders["X-API-KEY"], forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue(CactaceaAPI.customHeaders["X-AUTHORIZATION"], forHTTPHeaderField: "X-AUTHORIZATION")
        return urlRequest
    }

}

extension Session {
    
    static private func messageFromError(_ error: Error) -> String {
        if let err = error as? ErrorResponse {
            switch(err){
            case ErrorResponse.error(_, let data, let error):
                if let data = data {
                    let decodeResult = CodableHelper.decode(CactaceaErrors.self, from: data)
                    if decodeResult.error == nil {
                        if let m = decodeResult.decodableObj?.errors.first {
                            return m.message
                        }
                    }
                }
                return error.localizedDescription
            }
        }
        return error.localizedDescription
    }
    
    static func showError(_ error: Error) {
        let message = messageFromError(error)
        let alert = UIAlertController(title:nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        alert.show(completion: nil)
    }

}
