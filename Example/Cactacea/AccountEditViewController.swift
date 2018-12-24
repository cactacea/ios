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

protocol AccountEditViewControllerDelegate {
    func updateUserInfor()
}

class AccountEditViewController: UITableViewController {

    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var account: AccountDetail? = Session.authentication?.account
    
    var delegate: AccountEditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Account"
        accountNameTextField.delegate = self

        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        if let authentication = Session.authentication {
            self.navigationItem.title = authentication.account.accountName
            SessionAPI.findSession() { [weak self] (account, _) in
                guard let weakSelf = self else { return }
                guard let account = account else { return }
                authentication.account = account
                weakSelf.refreshProfile()
            }
        }
    }
    
    func refreshProfile() {
        if let authentication = Session.authentication {
            self.accountNameTextField.text = authentication.account.accountName
            if let smallImageURL = authentication.account.profileImageUrl {
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

extension AccountEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let accountName = textField.text {
            let body = PutSessionAccountNameBody(name: accountName)
            SessionAPI.updateAccountName(body: body) { (error) in
                if let error = error {
                    Session.showError(error)
                }
            }
            textField.resignFirstResponder()
        } else {
            textField.text = Session.authentication?.account.accountName
            textField.resignFirstResponder()
        }
        return true
    }
}
