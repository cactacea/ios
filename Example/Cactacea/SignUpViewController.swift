//
//  SignUpViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import RxSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet var profileImageButton: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    private var profileImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabOnView)))
    }
    
    @objc func tabOnView(sender: UIView) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    private func resetInputFields() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.userNameTextField.isUserInteractionEnabled = true
        self.passwordTextField.isUserInteractionEnabled = true
        self.signInButton.isUserInteractionEnabled = true
        self.signUpButton.isEnabled = true
        self.signUpButton.backgroundColor = UIColor.mainBlue
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        let isFormValid = userNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.mainBlue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.mainLightBlue
        }
    }
    
    @IBAction func profileImageButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let userName = userNameTextField.text, let password = passwordTextField.text else { return }

        userNameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        signInButton.isUserInteractionEnabled = false
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor.mainLightBlue
        signUpButton.showsActivityIndicator = true
        signUpButton.setTitle("", for: .normal)
        
        let request = PostSignUpBody(authType: PostSignUpBody.AuthType.username, identifier: userName, password: password)
        SessionsAPI.signUp(body: request) { [weak self] (error) in
            guard let weakSelf = self else { return }
            weakSelf.signUpButton.showsActivityIndicator = false
            weakSelf.signUpButton.setTitle("Signup", for: .normal)
            if let error = error {
                Session.showError(error)
                weakSelf.resetInputFields()
            } else {
                SessionAPI.findSession(completion: { (user, error) in
                    Session.user = user
                    weakSelf.updateProfileImage()
                    weakSelf.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    func updateProfileImage() {
        guard let image = profileImage?.resizeImage(newWidth: 200) else {
            return
        }
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

extension SignUpViewController: UINavigationControllerDelegate {
    
}

extension SignUpViewController: UIImagePickerControllerDelegate {
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

