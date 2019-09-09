//
//  SignInViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea

class SignInViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabOnView)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextField.text = "shinzo_abe"
        passwordTextField.text = "Password_2018"
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.mainBlue
    }

    @objc func tabOnView(sender: UIView) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func resetInputFields() {
        self.userNameTextField.isUserInteractionEnabled = true
        self.passwordTextField.isUserInteractionEnabled = true
        signUpButton.isUserInteractionEnabled = true
        self.loginButton.isEnabled = true
        self.loginButton.backgroundColor = UIColor.mainBlue
    }

    @IBAction func loginButtonTapped() {
        guard let userName = userNameTextField.text, let password = passwordTextField.text else { return }
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        userNameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        signUpButton.isUserInteractionEnabled = false
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.mainLightBlue
        loginButton.setTitle("", for: .normal)
        loginButton.showsActivityIndicator = true

        let body = PostSignInBody(authType: PostSignInBody.AuthType.username, identifier: userName, password: password)
        SessionsAPI.signIn(body: body) { [weak self] (error) in
            guard let weakSelf = self else { return }
            weakSelf.loginButton.showsActivityIndicator = false
            weakSelf.loginButton.setTitle("Login", for: .normal)
            if let error = error {
                Session.showError(error)
                weakSelf.resetInputFields()
            } else {
                SessionAPI.findSession(completion: { (user, error) in
                    Session.user = user
                    weakSelf.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        let isFormValid = userNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.mainBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.mainLightBlue
        }
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
