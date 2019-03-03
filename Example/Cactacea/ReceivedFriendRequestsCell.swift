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
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var rejectButton: UIButton!

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
            acceptButton.isHidden = false
            rejectButton.isHidden = false
            acceptButton.backgroundColor = UIColor.mainBlue
        } else if friendRequest.requestStatus == .accepted {
            acceptButton.setTitle("Accepted", for: .normal)
            acceptButton.backgroundColor = UIColor.mainLightBlue
            acceptButton.isHidden = false
            acceptButton.isEnabled = false
            rejectButton.isHidden = true
        } else if friendRequest.requestStatus == .rejected {
            acceptButton.isHidden = true
            rejectButton.setTitle("Rejected", for: .normal)
            rejectButton.isHidden = false
            rejectButton.isEnabled = false
        }
        acceptButton.showsActivityIndicator = false
    }

    @IBAction func tappedAccept(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }

        acceptButton.isEnabled = false
        acceptButton.backgroundColor = UIColor.mainLightBlue
        acceptButton.showsActivityIndicator = true
        acceptButton.setTitle("", for: .normal)
        rejectButton.isEnabled = false

        FriendRequestsAPI.accept(id: friendRequest.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                friendRequest.requestStatus = .accepted
            }
            weakSelf.updateButtons()
        }
    }

    @IBAction func tappedReject(_ sender: Any) {
        guard let friendRequest = friendRequest else { return }

        acceptButton.isEnabled = false
        acceptButton.backgroundColor = UIColor.mainLightBlue
        acceptButton.showsActivityIndicator = true
        acceptButton.setTitle("", for: .normal)
        rejectButton.isEnabled = false
        
        FriendRequestsAPI.reject(id: friendRequest.id) { [weak self] (error) in
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
