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

class FollowingUserCell: UITableViewCell {
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    
    var account: Account? {
        didSet {
            updateAccount()
            updateButtons()
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
    
    func updateButtons() {
        guard let account = account else { return }
        
        if account.following == true  {
            cancelButton.backgroundColor = UIColor.mainBlue
            cancelButton.setTitle("Unblock", for: .normal)
        } else {
            cancelButton.backgroundColor = UIColor.mainBlue
            cancelButton.setTitle("Block", for: .normal)
        }
        cancelButton.showsActivityIndicator = false
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        guard let account = account else { return }
        
        cancelButton.isEnabled = false
        cancelButton.backgroundColor = UIColor.mainLightBlue
        cancelButton.showsActivityIndicator = true
        cancelButton.setTitle("", for: .normal)
        
        if account.following {
            BlocksAPI.block(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.following = false
                }
                weakSelf.updateButtons()
            }
        } else {
            BlocksAPI.unblock(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.following = true
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

