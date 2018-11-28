//
//  MainController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        self.delegate = self
        if Session.authentication == nil {
            DispatchQueue.main.async { // wait until MainTabBarController is inside UI
                self.performSegue(withIdentifier: "signIn", sender: nil)
            }
        }
    }

}

extension MainController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            performSegue(withIdentifier: "photo", sender: nil)
            return false
        }
        return true
    }
}
