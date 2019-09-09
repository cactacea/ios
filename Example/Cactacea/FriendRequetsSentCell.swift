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
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    
    var friendRequest: FriendRequest? {
        didSet {
            updateFriendRequest()
        }
    }
    
    func updateFriendRequest() {
        guard let friendRequest = friendRequest else { return }
        
        userNameLabel.text = friendRequest.user.userName
        if let smallImageURL = friendRequest.user.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
        cancelButton.backgroundColor = UIColor.mainBlue
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.isEnabled = true
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }
        
        cancelButton.isEnabled = false
        cancelButton.backgroundColor = UIColor.mainLightBlue
        cancelButton.showsActivityIndicator = true
        cancelButton.setTitle("", for: .normal)
        
        UsersAPI.deleteRequest(id: friendRequest.user.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                weakSelf.cancelButton.backgroundColor = UIColor.mainLightBlue
                weakSelf.cancelButton.setTitle("Deleted", for: .normal)
                weakSelf.cancelButton.isEnabled = false
            }
            weakSelf.cancelButton.showsActivityIndicator = false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }
    
}
