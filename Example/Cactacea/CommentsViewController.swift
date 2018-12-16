//
//  CommentViewController.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/1/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import Cactacea

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    var feed: Feed!
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 77
        tableView.rowHeight = UITableView.automaticDimension
        empty()
        handleTextField()
        loadComments()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print(notification)
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()

        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = 0
            self.view.layoutIfNeeded()
            
        }
    }
    
    func loadComments() {
        CommentsAPI.findComments(id: feed.id, since: nil, offset: nil, count: nil) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
//                weakSelf.comments.append(contentsOf: result)
                weakSelf.comments = result
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    func handleTextField() {
        commentTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        if let commentText = commentTextField.text, !commentText.isEmpty {
            sendButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            sendButton.isEnabled = true
        } else {
            sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
            sendButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedSendButton(_ sender: Any) {
        guard let message = commentTextField.text else { return }
        let body = PostCommentBody(id: feed.id, message: message)
        CommentsAPI.post(body: body) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let _ = result {
                weakSelf.loadComments()
            }
            weakSelf.empty()
            weakSelf.view.endEditing(true)
        }
    }
    
    func empty() {
        self.commentTextField.text = ""
        self.sendButton.isEnabled = false
        sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
    }
    
}

extension CommentsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.row]
        cell.delegate = self
        return cell
    }

}

extension CommentsViewController: CommentTableViewCellDelegate {

    func tappedProfile(account: Account) {
        performSegue(withIdentifier: "profile", sender: account)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
//            let vc = segue.destination as! ProfileViewController
//            let account = sender  as! Account
//            vc.account = account
        }
    }

}








