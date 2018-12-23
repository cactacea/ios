//
//  ProfileEditViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/20.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import YPImagePicker
import Cactacea
import AlamofireImage

class ProfileEditViewController: UITableViewController {
    
    @IBOutlet weak var displayNameTextFiled: UITextField!
    @IBOutlet weak var webTextFiled: UITextField!
    @IBOutlet weak var birthdayTextFiled: UITextField!
    @IBOutlet weak var locationTextFiled: UITextField!
    @IBOutlet weak var bioTextView: UITextView!

    var account: Account? = Session.authentication?.account
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Profile"

        displayNameTextFiled.delegate = self
        webTextFiled.delegate = self
        birthdayTextFiled.delegate = self
        locationTextFiled.delegate = self
        bioTextView.delegate = self
        
        refreshProfile()
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
            self.displayNameTextFiled.text = authentication.account.displayName
            self.webTextFiled.text = authentication.account.web
//            self.birthdayTextFiled.text = authentication.account.birthday
            self.locationTextFiled.text = authentication.account.location
            self.bioTextView.text = authentication.account.bio
        }
    }
    
    @IBAction func tapSave(_ sender: Any) {

        if let authentication = Session.authentication {
            let displayName = self.displayNameTextFiled.text ?? authentication.account.displayName
            let body = PutSessionProfileBody(
                displayName: displayName,
                web: self.webTextFiled.text,
                birthday: nil,
                location: self.locationTextFiled.text,
                bio: self.bioTextView.text)

            SessionAPI.updateProfile(body: body) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    weakSelf.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.displayNameTextFiled {
            if let text = textField.text {
                if text.isEmpty {
                    textField.text = Session.authentication?.account.displayName
                }
            } else {
                textField.text = Session.authentication?.account.displayName
            }
        }
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
