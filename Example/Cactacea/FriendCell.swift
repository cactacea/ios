//
//  FriendCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class FriendCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var actionButton: UIButton!
    
    var user: User? {
        didSet {
            updateUser()
            updateButtons()
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
    
    func updateButtons() {
        guard let user = user else { return }
        
        if user.isFriend == true  {
            actionButton.backgroundColor = UIColor.mainBlue
            actionButton.setTitle("Unfriend", for: .normal)
            actionButton.isEnabled = true
        } else {
            actionButton.backgroundColor = UIColor.mainLightBlue
            actionButton.setTitle("Unfriended", for: .normal)
            actionButton.isEnabled = false
        }
        actionButton.showsActivityIndicator = false
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
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
                weakSelf.updateButtons()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }
    
}

