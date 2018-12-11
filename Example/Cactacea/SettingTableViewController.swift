//
//  SettingTableViewController.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 2/11/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit

protocol SettingTableViewControllerDelegate {
    func updateUserInfor()
}

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var usernnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var delegate: SettingTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Profile"
        usernnameTextField.delegate = self
        emailTextField.delegate = self
//        fetchCurrentUser()
    }
    
//    func fetchCurrentUser() {
////        Api.User.observeCurrentUser { (user) in
////            self.usernnameTextField.text = user.username
////            self.emailTextField.text = user.email
////            if let profileUrl = URL(string: user.profileImageUrl!) {
////                self.profileImageView.sd_setImage(with: profileUrl)
////            }
////        }
//    }

    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
//        if let profileImg = self.profileImageView.image, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
//            ProgressHUD.show("Waiting...")
//            AuthService.updateUserInfor(username: usernnameTextField.text!, email: emailTextField.text!, imageData: imageData, onSuccess: {
//                ProgressHUD.showSuccess("Success")
//                self.delegate?.updateUserInfor()
//            }, onError: { (errorMessage) in
//                ProgressHUD.showError(errorMessage)
//            })
//        }
    }

    @IBAction func logoutBtn_TouchUpInside(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let logOutAction = UIAlertAction(title: "Log Out", style: .default) { (_) in
            Session.authentication = nil
            if let vc = self.tabBarController as? MainController {
                vc.showSignIn()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.tabBarController?.selectedIndex = 0
                    self.navigationController?.popToRootViewController(animated: false)
                }
            }
        }
        alertController.addAction(logOutAction)
        self.present(alertController, animated: true, completion: nil)
//        AuthService.logout(onSuccess: {
//            let storyboard = UIStoryboard(name: "Start", bundle: nil)
//            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
//            self.present(signInVC, animated: true, completion: nil)
//        }) { (errorMessage) in
//            ProgressHUD.showError(errorMessage)
//        }
    }
    
    @IBAction func changeProfileBtn_TouchUpInside(_ sender: Any) {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        present(pickerController, animated: true, completion: nil)
    }

}

//extension SettingTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//// Local variable inserted by Swift 4.2 migrator.
//let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//
//        print("did Finish Picking Media")
//        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//            profileImageView.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}

extension SettingTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}












































// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
