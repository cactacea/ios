//
//  ProfileViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/09.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import AlamofireImage

protocol ProfileHeaderReusableViewDelegate {
    func updateFollowButton(forUser user: Account)
}

protocol ProfileHeaderReusableViewDelegateSwitchSettingVC {
    func goToSettingVC()
}

class ProfileHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPostsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileHeaderReusableViewDelegate?
    var delegate2: ProfileHeaderReusableViewDelegateSwitchSettingVC?
    var user: Account! {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    func updateView() {        
        self.nameLabel.text = user.accountName
        
        if let smallImageURL = user.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImage.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
        
        self.myPostsCountLabel.text = "\(user.feedsCount ?? 0)"
        self.followingCountLabel.text = "\(user.followCount ?? 0)"
        self.followersCountLabel.text = "\(user.followerCount ?? 0)"

        if user.id == Session.authentication?.account.id {
            followButton.setTitle("Edit Profile", for: UIControl.State.normal)
            followButton.addTarget(self, action: #selector(self.goToSettingVC), for: UIControl.Event.touchUpInside)

        } else {
            updateStateFollowButton()
        }
    }
    
    func clear() {
        self.nameLabel.text = ""
        self.myPostsCountLabel.text = ""
        self.followersCountLabel.text = ""
        self.followingCountLabel.text = ""
    }
    
    @objc func goToSettingVC() {
        delegate2?.goToSettingVC()
    }
    
    func updateStateFollowButton() {
        if user.follow {
            configureUnFollowButton()
        } else {
            configureFollowButton()
        }
    }
    
    func configureFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        followButton.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        followButton.setTitle("Follow", for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.followAction), for: UIControl.Event.touchUpInside)
    }
    
    func configureUnFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        followButton.backgroundColor = UIColor.clear
        followButton.setTitle("Following", for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func followAction() {
        if user.follow == false {
            FollowsAPI.follow(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    weakSelf.configureUnFollowButton()
                    weakSelf.user.follow = true
                }
            }
        }
    }
    
    @objc func unFollowAction() {
        if user.follow == true {
            FollowsAPI.unfollow(id: user.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    weakSelf.configureFollowButton()
                    weakSelf.user.follow = false
                    weakSelf.delegate?.updateFollowButton(forUser: weakSelf.user)
                }
            }
        }
    }

}
