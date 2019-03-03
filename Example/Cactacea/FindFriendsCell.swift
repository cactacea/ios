//
//  FindFriendsCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/03.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class FindFriendsCell: UITableViewCell {
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var actionButton: UIButton!

    var account: Account? {
        didSet {
            updateAccount()
            updateAddFriendButton()
        }
    }

    func updateAccount() {
        guard let account = account else { return }

        accountNameLabel.text = account.accountName
        if let smallImageURL = account.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
    }
    
    func updateAddFriendButton() {
        guard let account = account else { return }
        
        if account.isFriend {
            actionButton.setTitle("Unfriend", for: .normal)
        } else if account.friendRequestInProgress {
            actionButton.setTitle("Cancel", for: .normal)
        } else  {
            actionButton.setTitle("Request", for: .normal)
        }

        actionButton.isEnabled = true
        actionButton.backgroundColor = UIColor.mainBlue
        actionButton.showsActivityIndicator = false
    }

    @IBAction func tappedAddFriend(_ sender: Any) {
        guard let account = account else { return }

        actionButton.isEnabled = false
        actionButton.backgroundColor = UIColor.mainLightBlue
        actionButton.showsActivityIndicator = true
        actionButton.setTitle("", for: .normal)
        
        if account.isFriend {
            AccountsAPI.unfriend(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.isFriend = false
                }
                weakSelf.updateAddFriendButton()
            }
        } else if account.friendRequestInProgress {
            AccountsAPI.unrequest(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.friendRequestInProgress = false
                }
                weakSelf.updateAddFriendButton()
            }
            
        } else {
            AccountsAPI.request(id: account.id) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let _ = result {
                    account.friendRequestInProgress = true
                }
                weakSelf.updateAddFriendButton()
            }
        }    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

}
