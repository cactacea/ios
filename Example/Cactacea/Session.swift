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
    
    static func initialize() {

        //
        if let uuid = UserDefaults.standard.string(forKey: "uuid"){
            Session.uuid = uuid
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.setValue(uuid, forKey: "uuid")
            Session.uuid = uuid
        }
        //        let keychain = Keychain(service: "io.github.cactace")
        //        Session.accessToken = keychain["access_token"]
        //        CactaceaAPI.basePath = "http://backend.cactacea.io"
        //        CactaceaAPI.requestBuilderFactory = CactaceaRequestBuilderFactory()
        

    }
    
    static var uuid: String = ""

    static var token: String? {
        didSet {
            CactaceaAPI.customHeaders["Authorization"] = token ?? ""
        }
    }

    static var user: User? {
        didSet {
            Device.updateToken(status: PutDeviceBody.Status.active)
        }
    }

    static var playerId: String? {
        didSet {
            Device.updateToken(status: PutDeviceBody.Status.active)
        }
    }

    static func showError(_ error: Error) {
        let message = error.message
        let alert = UIAlertController(title:nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        alert.show(completion: nil)
        
        // TODO : Session Timeout
        //        if Session.user == nil {
        //            // wait until MainTabBarController is inside UI
        //            DispatchQueue.main.async {
        //                self.showSignIn()
        //            }
        //        } else {
        //            Session.updateToken()
        //        }

        
    }

}
