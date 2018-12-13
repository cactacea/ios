//
//  MainController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea All rights reserved.
//

import UIKit
//import YPImagePicker

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        self.delegate = self
        if Session.authentication == nil {
            // wait until MainTabBarController is inside UI
            DispatchQueue.main.async {
                self.showSignIn()
            }
        }
    }
    
    func showSignIn() {
        self.performSegue(withIdentifier: "signIn", sender: nil)
    }

}

extension MainController: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let index = viewControllers?.index(of: viewController)
//        if index == 2 {
//            var config = YPImagePickerConfiguration()
//            config.startOnScreen = .library
//            let picker = YPImagePicker(configuration: config)
//            picker.didFinishPicking { [unowned picker] items, cancelled in
//                if cancelled {
//                    picker.dismiss(animated: true, completion: nil)
//                } else if let photo = items.singlePhoto {
//                    let vc = SharePhotoController.instantinate()
//                    vc.selectedImage = photo.modifiedImage ?? photo.image
//                    picker.pushViewController(vc, animated: true)
//                } else if let video = items.singleVideo {
//                    video.fetchData(completion: { (data) in
//                        let vc = SharePhotoController.instantinate()
//                        vc.selectedImage = video.thumbnail
//                        vc.selectedVideo = data
//                        picker.pushViewController(vc, animated: true)
//                    })
//                } else {
//                    picker.dismiss(animated: true, completion: nil)
//                }
//            }
//            present(picker, animated: true, completion: nil)
//            return false
//        }
//        return true
//    }
    
}
