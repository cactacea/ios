//
//  UIColor+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mainBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
    static var mainLightBlue = UIColor.rgb(red: 149, green: 204, blue: 244)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
