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
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var actionButton: UIButton!

    var user: User? {
        didSet {
            updateUser()
            updateAddFriendButton()
        }
    }

    func updateUser() {
        guard let user = user else { return }

        userNameLabel.text = user.userName
        if let smallImageURL = user.profileImageUrl {
            let urlRequest = URLRequest.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
    }
    
    func updateAddFriendButton() {
        guard let user = user else { return }
        
        if user.isFriend {
            actionButton.setTitle("Unfriend", for: .normal)
        } else if user.friendRequestInProgress {
            actionButton.setTitle("Cancel", for: .normal)
        } else  {
            actionButton.setTitle("Request", for: .normal)
        }

        actionButton.isEnabled = true
        actionButton.backgroundColor = UIColor.mainBlue
        actionButton.showsActivityIndicator = false
    }

    @IBAction func tappedAddFriend(_ sender: Any) {
        guard let user = user else { return }

        actionButton.isEnabled = false
        actionButton.backgroundColor = UIColor.mainLightBlue
        actionButton.showsActivityIndicator = true
        actionButton.setTitle("", for: .normal)
        
        if user.isFriend {
            UsersAPI.unfriend(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    user.isFriend = false
                }
                weakSelf.updateAddFriendButton()
            }
        } else if user.friendRequestInProgress {
            UsersAPI.deleteRequest(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    user.friendRequestInProgress = false
                }
                weakSelf.updateAddFriendButton()
            }
            
        } else {
            UsersAPI.createRequest(id: user.id) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let _ = result {
                    user.friendRequestInProgress = true
                }
                weakSelf.updateAddFriendButton()
            }
        }    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

}
