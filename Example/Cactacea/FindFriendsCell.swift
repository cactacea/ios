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
        }
    }

    func updateAccount() {
        if let account = account {
            accountNameLabel.text = account.accountName
            if let smallImageURL = account.profileImageUrl {
                let urlRequest = Session.request(url: smallImageURL)
                let placeholderImage = UIImage(named: "placeholder_profile")
                self.profileImageView.af_setImage(withURLRequest: urlRequest,
                                             placeholderImage: placeholderImage,
                                             filter: nil,
                                             progress: nil,
                                             progressQueue: nil,
                                             imageTransition: .crossDissolve(0.2),
                                             runImageTransitionIfCached: false,
                                             completion: nil)
            }
        }
    }
    
    func updateAddFriendButton() {
        if let account = account {
            if account.friend {
                addFriendButton.setTitle("Unfriend", for: .normal)
                addFriendButton.isEnabled = true
            } else if account.friendRequestInProgress {
                addFriendButton.setTitle("Requested", for: .disabled)
                addFriendButton.isEnabled = false
            } else if account.friendRequestInProgress {
                addFriendButton.setTitle("Friend Request", for: .normal)
                addFriendButton.isEnabled = true
            }
        }
    }

    @IBAction func tappedAddFriend(_ sender: Any) {
        if let account = account {
            if account.friend {
                FriendsAPI.deleteFriend(id: account.id) { [weak self] (error) in
                    guard let weakSelf = self else { return }
                    if let error = error {
                        Session.showError(error)
                    } else {
                        account.friend = false
                        weakSelf.updateAddFriendButton()
                    }
                }
            } else if account.friendRequestInProgress {
                RequestsAPI.create(id: account.id) { [weak self] (result, error) in
                    guard let weakSelf = self else { return }
                    if let error = error {
                        Session.showError(error)
                    } else if let _ = result {
                        account.friendRequestInProgress = true
                        weakSelf.updateAddFriendButton()
                    }
                }
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

}
