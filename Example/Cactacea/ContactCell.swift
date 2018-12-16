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
    
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    var account: Account? {
        didSet {
            updateAccount()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }
    
}
