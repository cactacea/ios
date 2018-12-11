//
//  SharePhotoController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/27.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import RxSwift

class SharePhotoController: UIViewController {
    
    static func instantinate() -> SharePhotoController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: SharePhotoController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "SharePhotoController") as! SharePhotoController
        return vc
    }
    
    var selectedImage: UIImage?
    var selectedVideo: Data?

    var shareButton: UIBarButtonItem?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textView: PlaceholderTextView!
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = selectedImage
        self.textView.placeholderLabel.text = "Add a caption..."
        self.textView.placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        self.textView.font = UIFont.systemFont(ofSize: 14)
        self.textView.autocorrectionType = .no

    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        self.shareButton = navigationItem.rightBarButtonItem
        self.navigationItem.setRightBarButton(UIBarButtonItem.activityIndicator(.gray), animated: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        textView.isUserInteractionEnabled = false

        var uploadData: Data? = nil
        var fileExtension = ""
        if let selectedVideo = selectedVideo {
            fileExtension = ".mov"
            uploadData = selectedVideo
        } else if let selectedImage = selectedImage?.resizeImage(newWidth: 200)  {
            fileExtension = ".jpeg"
            uploadData = selectedImage.jpegData(compressionQuality: 0.7)
        }
        
        if let data = uploadData {
            MediumsAPI.uploadMedium(data: data, fileExtension: fileExtension) { (result, error) in
                if let error = error {
                    Session.showError(error)
                } else if let medium = result?.first {
                    let postFeedBody = PostFeedBody(message: self.textView.text, mediumIds: [medium.id], tags: nil, privacyType: PostFeedBody.PrivacyType.everyone, contentWarning: false, expiration: nil)
                    FeedsAPI.postFeed(body: postFeedBody, completion: { (result, error) in
                        if let error = error {
                            Session.showError(error)
                        } else {
                            NotificationCenter.default.post(name: NSNotification.Name.updateHomeFeed, object: nil)
                            NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
                        }
                    })
                }
            }
            self.dismiss(animated: true, completion: nil)

        } else {
            let postFeedBody = PostFeedBody(message: self.textView.text, mediumIds: nil, tags: nil, privacyType: PostFeedBody.PrivacyType.everyone, contentWarning: false, expiration: nil)
            FeedsAPI.postFeed(body: postFeedBody, completion: { (result, error) in
                if let error = error {
                    Session.showError(error)
                } else {
                    NotificationCenter.default.post(name: NSNotification.Name.updateHomeFeed, object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
                }
            })

            self.dismiss(animated: true, completion: nil)

        }
        
    }

}








//        self.shareButton = navigationItem.rightBarButtonItem
//        self.navigationItem.setRightBarButton(UIBarButtonItem.activityIndicator(.gray), animated: false)
//        navigationItem.rightBarButtonItem?.isEnabled = false
//        textView.isUserInteractionEnabled = false
//
//        let postFeedBody = PostFeedBody(message: self.textView.text, mediumIds: nil, tags: nil, privacyType: PostFeedBody.PrivacyType.everyone, contentWarning: false, expiration: nil)
//        FeedsAPI.postFeed(body: postFeedBody) { [weak self] (result, error) in
//            guard let weakSelf = self else { return }
//            if let error = error {
//                weakSelf.navigationItem.setRightBarButton(weakSelf.shareButton, animated: false)
//                weakSelf.navigationItem.rightBarButtonItem?.isEnabled = true
//                weakSelf.shareButton = nil
//                weakSelf.textView.isUserInteractionEnabled = true
//                Session.showError(error)
//            } else {
//                NotificationCenter.default.post(name: NSNotification.Name.updateHomeFeed, object: nil)
//                NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
//                weakSelf.shareButton = nil
//                weakSelf.dismiss(animated: true, completion: nil)
//            }
//        }
