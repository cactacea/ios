//
//  Extensions.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import Foundation
import UIKit
import Cactacea

extension UIViewController {

    private func messageFromError(_ error: Error) -> String {
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

    func show(_ error: Error) {
        let message = messageFromError(error)
        let alert = UIAlertController(title:nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIButton {
    
    /// Boolean value indicating whether an activity indicator should be shown.
    internal var showsActivityIndicator: Bool {
        
        get {
            return activityIndicatorView.superview != nil
        }
        
        set {
            if newValue {
                addSubview(activityIndicatorView)
                activityIndicatorView.startAnimating()
                addActivityIndicatorViewConstraints()
                titleLabel?.alpha = 0.0 // Use alpha to hide, since isHidden does not work.
                
            } else {
                activityIndicatorView.removeFromSuperview()
                activityIndicatorView.stopAnimating()
                removeActivityIndicatorViewConstraints()
                titleLabel?.alpha = 1.0 // Use alpha to hide, since isHidden does not work.
            }
        }
    }
    
    // MARK: - Activity Indicator View
    
    private var activityIndicatorView: UIActivityIndicatorView {
        if let activityIndicatorView = objc_getAssociatedObject(self, &AssociatedObjectKeys.activityIndicatorView) as? UIActivityIndicatorView {
            return activityIndicatorView
        }
        
        #if swift(>=4.2)
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        #else
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        #endif
        activityIndicatorView.color = activityIndicatorViewColor
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        objc_setAssociatedObject(self, &AssociatedObjectKeys.activityIndicatorView, activityIndicatorView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return activityIndicatorView
    }
    
    private var activityIndicatorViewColor: UIColor? {
        let foregroundColor = attributedTitle(for: .normal)?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        
        return foregroundColor ?? titleLabel?.textColor
    }
    
    private func addActivityIndicatorViewConstraints() {
        guard activityIndicatorView.constraints.isEmpty else {
            return
        }
        
        let constraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func removeActivityIndicatorViewConstraints() {
        NSLayoutConstraint.deactivate(activityIndicatorView.constraints)
    }
    
    // MARK: - AssociatedObjectKeys
    
    private struct AssociatedObjectKeys {
        static var activityIndicatorView = "checkout_activityIndicatorView"
    }
    
}


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

extension UIColor {
    
    static var mainBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
    static var mainLightBlue = UIColor.rgb(red: 149, green: 204, blue: 244)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension Date {
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo == 0 {
            return "Just now"
        }
        if secondsAgo < minute {
            if secondsAgo == 1 {
                return "\(secondsAgo) second ago"
            } else {
                return "\(secondsAgo) seconds ago"
            }
        } else if secondsAgo < hour {
            if secondsAgo / minute == 1 {
                return "\(secondsAgo / minute) minute ago"
            } else {
                return "\(secondsAgo / minute) minutes ago"
            }
        } else if secondsAgo < day {
            if secondsAgo / hour == 1 {
                return "\(secondsAgo / hour) hour ago"
            } else {
                return "\(secondsAgo / hour) hours ago"
            }
        } else if secondsAgo < week {
            if secondsAgo / day == 1 {
                return "\(secondsAgo / day) day ago"
            } else {
                return "\(secondsAgo / day) days ago"
            }
        }
        
        if secondsAgo / week == 1 {
            return "\(secondsAgo / week) week ago"
        } else {
            return "\(secondsAgo / week) weeks ago"
        }
    }
    
    func timeAgoDisplayShort() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo == 0 {
            return "Just now"
        }
        if secondsAgo < minute {
            return "\(secondsAgo)s"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h"
        } else if secondsAgo < week {
            return "\(secondsAgo / day)d"
        }
        
        return "\(secondsAgo / week)wk"
    }
}

extension NSNotification.Name {
    static var updateHomeFeed = NSNotification.Name(rawValue: "updateFeed")
    static var updateUserProfileFeed = NSNotification.Name(rawValue: "updateUserProfileFeed")
}
