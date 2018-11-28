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
    
    static var authentication: Authentication? {
        didSet {
            CactaceaAPI.customHeaders["X-AUTHORIZATION"] = authentication?.accessToken
        }
    }

}
