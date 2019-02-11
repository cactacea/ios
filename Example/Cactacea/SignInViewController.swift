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

    @IBOutlet var accountNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabOnView)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountNameTextField.text = "shinzo_abe"
        passwordTextField.text = "Password_2018"
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.mainBlue
    }

    @objc func tabOnView(sender: UIView) {
        accountNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func resetInputFields() {
        self.accountNameTextField.isUserInteractionEnabled = true
        self.passwordTextField.isUserInteractionEnabled = true
        self.loginButton.isEnabled = true
        self.loginButton.backgroundColor = UIColor.mainBlue
    }

    @IBAction func loginButtonTapped() {
        guard let accountName = accountNameTextField.text, let password = passwordTextField.text else { return }
        
        accountNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        accountNameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.mainLightBlue
        loginButton.setTitle("", for: .normal)
        loginButton.showsActivityIndicator = true

        SessionsAPI.signIn(accountName: accountName, password: password, udid: Session.uuid) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            weakSelf.loginButton.showsActivityIndicator = false
            weakSelf.loginButton.setTitle("Login", for: .normal)
            if let error = error {
                Session.showError(error)
                weakSelf.resetInputFields()
            } else {
                Session.authentication = result
                weakSelf.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        let isFormValid = accountNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
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
