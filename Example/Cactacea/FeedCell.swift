//
//  FeedCellTableViewCell.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/08.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import AVFoundation

protocol FeedCellDelegate {
    func tappedFeed(feed: Feed)
    func tappedProfile(user: User)
}

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var heightConstraintPhoto: NSLayoutConstraint!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var volumeButton: UIButton!
    
    var delegate: FeedCellDelegate?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    var feed: Feed? {
        didSet {
            updateFeed()
            updateLike()
        }
    }
    var user: User? {
        get {
            return feed?.user
        }
    }
    
    var mediums: [Medium]? {
        get {
            return feed?.mediums
        }
    }
    
    var isMuted = true
    
    func updateFeed() {
        guard let feed = feed else { return }
        captionLabel.text = feed.message
        if let medium = mediums?.first {
            let ratio = (CGFloat)(medium.width) / (CGFloat)(medium.height)
            heightConstraintPhoto.constant = UIScreen.main.bounds.width / ratio
            layoutIfNeeded()
            
            if let url = medium.thumbnailUrl {
                let urlRequest = Session.request(url: url)
                postImageView.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
            }
        }
        
        nameLabel.text = user?.userName
        if let smallImageURL = user?.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest, placeholderImage: UIImage(named: "placeholder_profile"), imageTransition: .crossDissolve(0.2))
        }
        

    }
    
    func updateLike() {
        guard let feed = feed else { return }
        let imageName = feed.liked ? "like_unselected" : "like_selected"
        likeImageView.image = UIImage(named: imageName)
        if feed.likeCount != 0 {
            likeCountButton.setTitle("\(feed.likeCount) likes", for: UIControl.State.normal)
        } else {
            likeCountButton.setTitle("Be the first like this", for: UIControl.State.normal)
        }
    }

    @IBAction func volumeButton_TouchUpInSide(_ sender: UIButton) {
        if isMuted {
            isMuted = !isMuted
            volumeButton.setImage(UIImage(named: "mute_selected"), for: UIControl.State.normal)
        } else {
            isMuted = !isMuted
            volumeButton.setImage(UIImage(named: "mute_unselected"), for: UIControl.State.normal)
            
        }
        player?.isMuted = isMuted
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        captionLabel.text = ""
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedFeed))
        commentImageView.addGestureRecognizer(tapGesture)
        commentImageView.isUserInteractionEnabled = true
        
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.tappedLike))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        
        let tapGestureForNameLabel = UITapGestureRecognizer(target: self, action: #selector(self.tappedName))
        nameLabel.addGestureRecognizer(tapGestureForNameLabel)
        nameLabel.isUserInteractionEnabled = true
    }
    
    
    @objc func tappedName() {
        if let user = user {
            delegate?.tappedProfile(user: user)
        }
    }
    
    @objc func tappedLike() {
        guard let feed = feed else { return }
        if feed.liked {
            FeedLikesAPI.unlikeFeed(id: feed.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    feed.likeCount = feed.likeCount - 1
                    feed.liked = false
                    weakSelf.updateLike()
                }
            }
        } else {
            FeedLikesAPI.likeFeed(id: feed.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else {
                    feed.likeCount = feed.likeCount + 1
                    feed.liked = true
                    weakSelf.updateLike()
                }
            }
        }
        
    }
    
    @objc func tappedFeed() {
        if let feed = feed {
            delegate?.tappedFeed(feed: feed)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
        postImageView.image = nil
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        self.volumeView.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

