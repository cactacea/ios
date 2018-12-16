//
//  FriendRequetsSentCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class FriendRequestsSentCell: UITableViewCell {
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    
    var friendRequest: FriendRequest? {
        didSet {
            updateFriendRequest()
            updateButtons()
        }
    }
    
    func updateFriendRequest() {
        guard let friendRequest = friendRequest else { return }
        
        accountNameLabel.text = friendRequest.account.accountName
        if let smallImageURL = friendRequest.account.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
    }
    
    func updateButtons() {
        guard let friendRequest = friendRequest else { return }
        
        if friendRequest.requestStatus == .noresponded  {
            cancelButton.backgroundColor = UIColor.mainBlue
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.isEnabled = true
        } else if friendRequest.requestStatus == .rejected {
            cancelButton.backgroundColor = UIColor.mainLightBlue
            cancelButton.setTitle("Cancelled", for: .normal)
            cancelButton.isEnabled = false
        }
        cancelButton.showsActivityIndicator = false
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }
        
        cancelButton.isEnabled = false
        cancelButton.backgroundColor = UIColor.mainLightBlue
        cancelButton.showsActivityIndicator = true
        cancelButton.setTitle("", for: .normal)
        
        FriendRequestsAPI.delete(id: friendRequest.account.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                friendRequest.requestStatus = .rejected
            }
            weakSelf.updateButtons()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }
    
}
