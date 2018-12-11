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
    @IBOutlet var addFriendButton: UIButton!

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
        
        if account.friend {
            addFriendButton.setTitle("Unfriend", for: .normal)
        } else if account.friendRequestInProgress {
            addFriendButton.setTitle("Cancel", for: .normal)
        } else  {
            addFriendButton.setTitle("Request", for: .normal)
        }

        addFriendButton.isEnabled = true
        addFriendButton.backgroundColor = UIColor.mainBlue
        addFriendButton.showsActivityIndicator = false
    }

    @IBAction func tappedAddFriend(_ sender: Any) {
        guard let account = account else { return }

        addFriendButton.isEnabled = false
        addFriendButton.backgroundColor = UIColor.mainLightBlue
        addFriendButton.showsActivityIndicator = true
        addFriendButton.setTitle("", for: .normal)
        
        if account.friend {
            FriendsAPI.deleteFriend(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.friend = false
                }
                weakSelf.updateAddFriendButton()
            }
        } else if account.friendRequestInProgress {
            RequestsAPI.delete(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.friendRequestInProgress = false
                }
                weakSelf.updateAddFriendButton()
            }
            
        } else {
            RequestsAPI.create(id: account.id) { [weak self] (result, error) in
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
