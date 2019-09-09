//
//  CommentViewController.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/1/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import Cactacea
import RxSwift

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    @IBOutlet weak var pageFooterView: PageFooterView!

    lazy private var pager = Pager<Comment>(tableView, pageFooterView)
    
    var feed: Feed!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pager.addOnTop = true
        self.pager.fetchBlock =  { [weak self] (paginator, first) -> Observable<[Comment]> in
            guard let weakSelf = self else { return Observable.empty() }
            let next = first ? nil : paginator.items.first?.next
            return CommentsAPI.findComments(id: weakSelf.feed.id, since: next, offset: nil, count: nil)
        }

        commentTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)

        empty()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = Session.user {
            self.pager.fetchFirst()
        }
    }

}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = self.pager.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = self.pager.items[indexPath.row]
        if let user = Session.user {
            if user.id != comment.user.id {
                performSegue(withIdentifier: "profile", sender: comment.user)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            let vc = segue.destination as! ProfileViewController
            let user = sender as! User
            vc.user = user
        }
    }

}

extension CommentsViewController {
    
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

    func empty() {
        self.commentTextField.text = ""
        self.sendButton.isEnabled = false
        sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
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

    @IBAction func tappedSendButton(_ sender: Any) {
        guard let message = commentTextField.text else { return }
        let body = PostCommentBody(id: feed.id, replyId: nil, message: message)
        CommentsAPI.postComment(body: body) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let _ = result {
                weakSelf.pager.fetchRerty()
            }
        }
        self.empty()
        self.view.endEditing(true)
    }

}









