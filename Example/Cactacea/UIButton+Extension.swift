//
//  UIButton+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

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
