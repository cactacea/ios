//
//  FriendsCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/03.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import Alamofire
import AlamofireImage

class ContactCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    var user: User? {
        didSet {
            updateUser()
        }
    }
    
    func updateUser() {
        guard let user = user else { return }
        
        userNameLabel.text = user.userName
        if let smallImageURL = user.profileImageUrl {
            let urlRequest = URLRequest.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }
    
}
