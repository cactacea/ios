//
//  CommentTableViewCell.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/1/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import Cactacea

//import ActiveLabel

protocol CommentTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var delegate: CommentTableViewCellDelegate?
    var comment: Comment? {
        didSet {
            updateView()
        }
    }
    
//    var user: User? {
//        didSet {
//            setupUserInfo()
//        }
//    }

    func updateView() {
        commentLabel.text = comment?.message
//        commentLabel.userHandleLinkTapHandler = {
//            label, handle, rang in
//            var mention = handle
//            mention = String(mention.characters.dropFirst())
//            Api.User.observeUserByUsername(username: mention.lowercased(), completion: { (user) in
//                self.delegate?.goToProfileUserVC(userId: user.id!)
//            })
//
//        }
        
        if let account = comment?.account {
            nameLabel.text = account.accountName
            if let smallImageURL = account.profileImageUrl {
                let urlRequest = Session.request(url: smallImageURL)
                profileImageView.af_setImage(withURLRequest: urlRequest)
            }
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        commentLabel.text = ""
        let tapGestureForNameLabel = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        nameLabel.addGestureRecognizer(tapGestureForNameLabel)
        nameLabel.isUserInteractionEnabled = true
    }
    
    @objc func nameLabel_TouchUpInside() {
        if let id = comment?.account._id {
//            delegate?.goToProfileUserVC(userId: id)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        profileImageView.image = UIImage(named: "placeholderImg")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
