//
//  UIBarButtonItem+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    static func emptyBackButton(_ target: AnyObject, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: target, action: action)
    }
    
    static func settingsButton(_ delegate: AnyObject, action: Selector) -> UIBarButtonItem {
        let icon = UIImage(named: "SettingsNavBar")!.withRenderingMode(.alwaysTemplate)
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: delegate, action: action)
        return barButton
    }
    
    static func imageButton(_ image: UIImage?, delegate: AnyObject, action: Selector) -> UIBarButtonItem {
        let icon = image?.withRenderingMode(.alwaysTemplate)
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: delegate, action: action)
        return barButton
    }
    
    static func imageBackButton(_ delegate: AnyObject, action: Selector) -> UIBarButtonItem {
        let icon =  UIImage(named: "BackButton")!.withRenderingMode(.alwaysTemplate)
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: delegate, action: action)
        return barButton
    }
    
    static func textBarButton(_ text: String, delegate: AnyObject, action: Selector, color: UIColor = .white) -> UIBarButtonItem {
        return UIBarButtonItem(title: text, style: .plain, target: delegate, action: action)
    }
    
    static func activityIndicator(_ style: UIActivityIndicatorView.Style = .white) -> UIBarButtonItem {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        return UIBarButtonItem(customView: activityIndicator)
    }
}
