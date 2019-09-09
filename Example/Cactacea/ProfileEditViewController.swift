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

    var user: User? = Session.user
    
    
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
            self.displayNameTextFiled.text = user.displayName
            self.webTextFiled.text = user.web
//            self.birthdayTextFiled.text = user.birthday
            self.locationTextFiled.text = user.location
            self.bioTextView.text = user.bio
        }
    }
    
    @IBAction func tapSave(_ sender: Any) {

        if let user = Session.user {
            let displayName = self.displayNameTextFiled.text ?? user.displayName
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
                    textField.text = Session.user?.displayName
                }
            } else {
                textField.text = Session.user?.displayName
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
