//
//  MainController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea All rights reserved.
//

import UIKit
import YPImagePicker
import Cactacea
import OneSignal

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        SessionAPI.findSession(completion: { [weak self] (user, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.showError(error)
            } else {
                Session.user = user
            }
        })
    }
    
    func showSignIn() {
        self.performSegue(withIdentifier: "signIn", sender: nil)
    }

}

extension MainController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            tapPlusButton()
            return false
        }
        return true
    }
    
}

extension MainController {

    func tapPlusButton() {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
            } else if let photo = items.singlePhoto {
                let vc = SharePhotoController.instantinate()
                vc.selectedImage = photo.modifiedImage ?? photo.image
                picker.pushViewController(vc, animated: true)
            } else if let video = items.singleVideo {
                video.fetchData(completion: { (data) in
                    let vc = SharePhotoController.instantinate()
                    vc.selectedImage = video.thumbnail
                    vc.selectedVideo = data
                    picker.pushViewController(vc, animated: true)
                })
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
        present(picker, animated: true, completion: nil)
    }

}
