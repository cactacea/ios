//
//  ProfileHeaderReusableView.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/09.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import AlamofireImage

class ProfileHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var user: User! {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    func updateView() {
        self.nameLabel.text = user.userName
        
        if let smallImageURL = user.profileImageUrl {
            let urlRequest = URLRequest.request(url: smallImageURL)
            profileImage.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
        
        self.postsCountLabel.text = "\(user.feedCount)"
        self.followCountLabel.text = "\(user.followCount)"
        self.followersCountLabel.text = "\(user.followerCount)"
        
        if user.follow {
            configureUnFollowButton()
        } else {
            configureFollowButton()
        }
    }
    
    func clear() {
        self.nameLabel.text = ""
        self.postsCountLabel.text = ""
        self.followersCountLabel.text = ""
        self.followCountLabel.text = ""
    }
    
    func configureFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        followButton.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        followButton.setTitle("Follow", for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.tappedFollow), for: UIControl.Event.touchUpInside)
    }
    
    func configureUnFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        followButton.backgroundColor = UIColor.clear
        followButton.setTitle("Following", for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.tappedUnfollow), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tappedFollow() {
        UsersAPI.followUser(id: user.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                weakSelf.configureUnFollowButton()
                weakSelf.user.follow = true
            }
        }
    }
    
    @objc func tappedUnfollow() {
        UsersAPI.unfollowUser(id: user.id) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else {
                weakSelf.configureFollowButton()
                weakSelf.user.follow = false
            }
        }
    }
    
}
