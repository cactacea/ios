//
//  MyProfileHeaderReusableView.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/09.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import AlamofireImage

protocol MyProfileHeaderReusableViewDelegate {
    func tappedEditButton()
}

class MyProfileHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: MyProfileHeaderReusableViewDelegate?
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
        
        self.postsCountLabel.text = "\(user.feedCount )"
        self.followCountLabel.text = "\(user.followCount)"
        self.followersCountLabel.text = "\(user.followerCount)"

        followButton.setTitle("Edit", for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.tappedEditButton), for: UIControl.Event.touchUpInside)

    }
    
    func clear() {
        self.nameLabel.text = ""
        self.postsCountLabel.text = ""
        self.followersCountLabel.text = ""
        self.followCountLabel.text = ""
    }
    
    @objc func tappedEditButton() {
        delegate?.tappedEditButton()
    }

}
