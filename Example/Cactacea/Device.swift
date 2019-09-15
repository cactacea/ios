//
//  Device.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/09/13.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import Cactacea

class Device {

    static func updateToken(status: PutDeviceBody.Status) {
        if let _ = Session.user {
            let body = PutDeviceBody(status: status, udid: Session.uuid, pushToken: Session.playerId)
            SettingsAPI.updateDeviceStatus(body: body) { (error) in
                if let error = error {
                    Session.showError(error)
                }
            }
        }
    }

}
