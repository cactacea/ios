//
//  OptionsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/09.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutBtn_TouchUpInside(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let logOutAction = UIAlertAction(title: "Log Out", style: .default) { (_) in
            Session.authentication = nil
            if let vc = self.tabBarController as? MainController {
                vc.showSignIn()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.tabBarController?.selectedIndex = 0
                    self.navigationController?.popToRootViewController(animated: false)
                }
            }
        }
        alertController.addAction(logOutAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
