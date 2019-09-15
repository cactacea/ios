//
//  SignInViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstaint: NSLayoutConstraint!

    var facebookButton: FBLoginButton!
    var googleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabOnView)))

        LoginManager().logOut()
        GIDSignIn.sharedInstance()?.signOut()

        self.initializedInputFieds()
        self.createFacebookLoginButton()
        self.createGoogleLoginButton()

        //        //        ログイン済みかチェック
        //        if let _ = FBSDKAccessToken.current() {
        //            //            画面遷移
        //            performSegue(withIdentifier: "modalTop", sender: self)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func tabOnView(sender: UIView) {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonTapped() {
        guard let userName = userNameTextField.text, let password = passwordTextField.text else { return }
        
        self.disabledInputFields()
        self.signIn(userName: userName, password: password)
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}


// Inpput fileds
extension SignInViewController {
    
    private func initializedInputFieds() {
        userNameTextField.text = ""
        passwordTextField.text = ""
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.mainBlue
    }
    
    private func enabledInputFields() {
        self.userNameTextField.isUserInteractionEnabled = true
        self.passwordTextField.isUserInteractionEnabled = true
        signUpButton.isUserInteractionEnabled = true
        self.loginButton.isEnabled = true
        self.loginButton.backgroundColor = UIColor.mainBlue
    }
    
    private func disabledInputFields() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        userNameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        signUpButton.isUserInteractionEnabled = false
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.mainLightBlue
        loginButton.setTitle("", for: .normal)
        loginButton.showsActivityIndicator = true
    }

}


// Facebook support
extension SignInViewController: LoginButtonDelegate {
    
    func createFacebookLoginButton() {
        facebookButton = FBLoginButton()
        facebookButton.permissions = ["public_profile", "email"]
        facebookButton.center = self.view.center
        facebookButton.delegate = self
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(facebookButton)
        self.stackViewHeightConstaint.constant = self.stackViewHeightConstaint.constant + 50.0
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            self.showError(error)
        } else {
            if let token = result?.token {
                self.socialSignIn(provider: "facebook",
                                  tokenString: token.tokenString,
                                  expiresIn: Int64(token.expirationDate.timeIntervalSince1970),
                                  secret: nil)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
}

extension SignInViewController: GIDSignInDelegate {

    func createGoogleLoginButton() {

        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        googleButton = GIDSignInButton()
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureForPhoto = UITapGestureRecognizer(target: self, action: #selector(self.googleTouchUpInside))
        googleButton.addGestureRecognizer(tapGestureForPhoto)
        
        self.stackView.addArrangedSubview(googleButton)
        self.stackViewHeightConstaint.constant = self.stackViewHeightConstaint.constant + 50.0
    }

    @objc func googleTouchUpInside() {
        GIDSignIn.sharedInstance()?.signIn()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                self.showError(error)
            }
            return
        }
        
        self.socialSignIn(
            provider: "google",
            tokenString: user.authentication.accessToken,
            expiresIn: Int64(user.authentication.accessTokenExpirationDate.timeIntervalSince1970),
            secret: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print(error.localizedDescription)
    }
    
}


// Call APIs
extension SignInViewController {
    
    func signIn(userName: String, password: String) {
        let body = PostSignInBody(authType: PostSignInBody.AuthType.username, identifier: userName, password: password)
        SessionsAPI.signIn(body: body) { [weak self] (token, error) in
            guard let weakSelf = self else { return }
            weakSelf.loginButton.showsActivityIndicator = false
            weakSelf.loginButton.setTitle("Login", for: .normal)
            if let error = error {
                weakSelf.showError(error)
                weakSelf.enabledInputFields()
            } else {
                weakSelf.showViewController(token: token)
            }
        }
    }
    
    func socialSignIn(provider: String, tokenString: String, expiresIn: Int64, secret: String?) {
        let body = PostSocialSignupBody(token: tokenString, expiresIn: expiresIn, secret: nil)
        SessionsAPI.socialSignUp(provider: provider, body: body) { [weak self] (token, error) in
            guard let weakSelf = self else { return }
            if let _ = error {
                LoginManager().logOut()
                print(error)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    weakSelf.showError(error)
//                }
            } else {
                weakSelf.showViewController(token: token)
            }
        }
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
    func showViewController(token: SessionToken?) {
        if let tokenString = token?.tokenString {
            Session.token = tokenString
        }
        if token?.userId == nil {
            self.performSegue(withIdentifier: "Register", sender: self)
        } else {
            self.performSegue(withIdentifier: "Top", sender: self)
        }
        self.enabledInputFields()
    }

}
