//
//  Error+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/09/12.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import Cactacea

extension Error {
    
    var httpStatusCode: Int {
        if let err = self as? ErrorResponse {
            switch(err){
            case ErrorResponse.error(let code, _, _):
                return code
            }
        }
        return 500
    }
    
    var errors: CactaceaErrors? {
        if let err = self as? ErrorResponse {
            switch(err){
            case ErrorResponse.error(_, let data, _):
                if let data = data {
                    let decodeResult = CodableHelper.decode(CactaceaErrors.self, from: data)
                    return decodeResult.decodableObj
                }
                return nil
            }
        }
        return nil
    }
    
    var message: String {
        if let error = self.errors?.errors.first {
            return error.message
        } else {
            return self.localizedDescription
        }
    }
    
}
