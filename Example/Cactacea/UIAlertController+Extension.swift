//
//  UIAlertController+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

extension UIAlertController {
    func show(completion: (() -> Void)?) {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            return
        }
        
        if let presentedViewController = rootViewController.presentedViewController {
            presentedViewController.present(self, animated: true, completion: completion)
        } else {
            rootViewController.present(self, animated: true, completion: completion)
        }
    }
}
