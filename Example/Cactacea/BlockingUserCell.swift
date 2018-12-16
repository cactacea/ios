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

class BlockingUserCell: UITableViewCell {
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var actionButton: UIButton!

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
        
        if account.blocking == true  {
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
        guard let account = account else { return }

        actionButton.isEnabled = false
        actionButton.backgroundColor = UIColor.mainLightBlue
        actionButton.showsActivityIndicator = true
        actionButton.setTitle("", for: .normal)
        
        if account.blocking {
            AccountsAPI.block(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.blocking = false
                }
                weakSelf.updateButtons()
            }
        } else {
            AccountsAPI.unblock(id: account.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    account.blocking = true
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

