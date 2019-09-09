//
//  SettingTableViewController.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 2/11/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import YPImagePicker
import Cactacea
import AlamofireImage

protocol UserEditViewControllerDelegate {
    func updateUserInfor()
}

class UserEditViewController: UITableViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var user: User? = Session.user
    
    var delegate: UserEditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit User"
        userNameTextField.delegate = self

        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        if let user = Session.user {
            self.navigationItem.title = user.userName
            SessionAPI.findSession() { [weak self] (user, _) in
                guard let weakSelf = self else { return }
                guard let user = user else { return }
                Session.user = user
                weakSelf.refreshProfile()
            }
        }
    }
    
    func refreshProfile() {
        if let user = Session.user {
            self.userNameTextField.text = user.userName
            if let smallImageURL = user.profileImageUrl {
                let urlRequest = Session.request(url: smallImageURL)
                profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
            }
        }
    }

    @IBAction func tapChangeProfile(_ sender: Any) {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                self.profileImageView.image = photo.modifiedImage
                if let image = photo.modifiedImage {
                    if let data = image.jpegData(compressionQuality: 0.7) {
                        MediumsAPI.uploadMedium(data: data, fileExtension: ".jpeg") { (result, error) in
                            if let error = error {
                                Session.showError(error)
                            } else if let result = result?.first {
                                let body = PutSessionProfileImageBody(id: result.id)
                                SessionAPI.updateProfileImage(body: body, completion: { (error) in
                                    if let error = error {
                                        Session.showError(error)
                                    }
                                })
                            }
                        }
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }

}

extension UserEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userName = textField.text {
            let body = PutUserNameBody(name: userName)
            SessionAPI.updateUserName(body: body) { (error) in
                if let error = error {
                    Session.showError(error)
                }
            }
            textField.resignFirstResponder()
        } else {
            textField.text = Session.user?.userName
            textField.resignFirstResponder()
        }
        return true
    }
}
