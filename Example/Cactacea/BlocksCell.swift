//
//  BlockedUserCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class BlocksCell: UITableViewCell {
    
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
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
    }
    
    func updateButtons() {
        guard let user = user else { return }
        
        if user.blocked == true  {
            actionButton.backgroundColor = UIColor.mainBlue
            actionButton.setTitle("Unblock", for: .normal)
        } else {
            actionButton.backgroundColor = UIColor.mainBlue
            actionButton.setTitle("Block", for: .normal)
        }
        actionButton.isEnabled = true
        actionButton.showsActivityIndicator = false
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        guard let user = user else { return }

        actionButton.isEnabled = false
        actionButton.backgroundColor = UIColor.mainLightBlue
        actionButton.showsActivityIndicator = true
        actionButton.setTitle("", for: .normal)
        
        if user.blocked {
            UsersAPI.block(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    user.blocked = false
                }
                weakSelf.updateButtons()
            }
        } else {
            UsersAPI.unblock(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    user.blocked = true
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

