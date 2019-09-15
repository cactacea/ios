//
//  UIViewController+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/09/12.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(_ error: Error) {
        let message = error.message
        let alert = UIAlertController(title:nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.show(alert, sender: nil)
        alert.show(completion: nil)
    }
    
}

