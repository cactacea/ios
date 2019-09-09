//
//  ReceivedRequestsCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/03.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class ReceivedFriendRequestsCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var rejectButton: UIButton!

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
        acceptButton.isHidden = false
        rejectButton.isHidden = false
        acceptButton.backgroundColor = UIColor.mainBlue
    }
    
    @IBAction func tappedAccept(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }

        acceptButton.isEnabled = false
        acceptButton.backgroundColor = UIColor.mainLightBlue
        acceptButton.showsActivityIndicator = true
        acceptButton.setTitle("", for: .normal)
        rejectButton.isEnabled = false

        FriendRequestsAPI.acceptRequest(id: friendRequest.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                weakSelf.acceptButton.setTitle("Accepted", for: .normal)
                weakSelf.acceptButton.backgroundColor = UIColor.mainLightBlue
                weakSelf.acceptButton.isHidden = false
                weakSelf.acceptButton.isEnabled = false
                weakSelf.rejectButton.isHidden = true
            }
            weakSelf.acceptButton.showsActivityIndicator = false
        }
    }

    @IBAction func tappedReject(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }

        acceptButton.isEnabled = false
        acceptButton.backgroundColor = UIColor.mainLightBlue
        acceptButton.showsActivityIndicator = true
        acceptButton.setTitle("", for: .normal)
        rejectButton.isEnabled = false
        
        FriendRequestsAPI.rejectRequest(id: friendRequest.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                weakSelf.acceptButton.isHidden = true
                weakSelf.rejectButton.setTitle("Rejected", for: .normal)
                weakSelf.rejectButton.isHidden = false
                weakSelf.rejectButton.isEnabled = false
            }
            weakSelf.acceptButton.showsActivityIndicator = false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

}
