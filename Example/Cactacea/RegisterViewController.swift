//
//  RegisterViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2019/09/12.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import RxSwift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabOnView)))
    }
    
    @objc func tabOnView(sender: UIView) {
        userNameTextField.resignFirstResponder()
    }
    
    private func resetInputFields() {
        userNameTextField.resignFirstResponder()
        self.userNameTextField.isUserInteractionEnabled = true
        self.registerButton.isEnabled = true
        self.registerButton.backgroundColor = UIColor.mainBlue
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        let isFormValid = userNameTextField.text?.isEmpty == false
        if isFormValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = UIColor.mainBlue
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor.mainLightBlue
        }
    }
    
    @IBAction func profileImageButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let userName = userNameTextField.text else { return }
        
        userNameTextField.isUserInteractionEnabled = false
        
        registerButton.isEnabled = false
        registerButton.backgroundColor = UIColor.mainLightBlue
        registerButton.showsActivityIndicator = true
        registerButton.setTitle("", for: .normal)

        let body = PostSessionBody(userName: userName, displayName: nil)
        SessionAPI.registerSession(body: body) { [weak self] (user, error) in
            guard let weakSelf = self else { return }
            weakSelf.registerButton.showsActivityIndicator = false
            if let error = error {
                Session.showError(error)
                weakSelf.resetInputFields()
            } else {
                Session.user = user
                
                if weakSelf.profileImage == nil {
                    weakSelf.performSegue(withIdentifier: "Top", sender: self)
                } else {
                    weakSelf.updateProfileImage()
                }
            }
        }
    }
    
    func updateProfileImage() {
        guard let image = profileImage?.resizeImage(newWidth: 200) else {
            self.registerButton.setTitle("Register", for: .normal)
            return
        }
        if let data = image.jpegData(compressionQuality: 0.7) {
            MediumsAPI.uploadMedium(data: data, fileExtension: ".jpeg") { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let result = result?.first {
                    let body = PutSessionProfileImageBody(id: result.id)
                    SessionAPI.updateProfileImage(body: body, completion: { (error) in
                        if let error = error {
                            Session.showError(error)
                        } else {
                            weakSelf.registerButton.setTitle("Register", for: .normal)
                            weakSelf.performSegue(withIdentifier: "Top", sender: self)
                        }
                    })
                }
            }
        }
    }
    
}

extension RegisterViewController: UINavigationControllerDelegate {
    
}

extension RegisterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            self.profileImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            profileImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            profileImage = originalImage
        }
        self.profileImageButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        self.profileImageButton.layer.borderWidth = 0.5
        dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
