//
//  CommentTableViewCell.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/1/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import Cactacea
import ActiveLabel

class CommentCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        commentLabel.text = comment?.message

        if let account = comment?.account {
            nameLabel.text = account.accountName
            if let smallImageURL = account.profileImageUrl {
                let urlRequest = Session.request(url: smallImageURL)
                profileImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
            }
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        commentLabel.text = ""
        nameLabel.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

}
