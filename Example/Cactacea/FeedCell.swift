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
    func goToCommentVC(feedId: Int64)
    func goToProfileUserVC(accountId: Int64)
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
    var account: Account? {
        get {
            return feed?.account
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
                postImageView.af_setImage(withURLRequest: urlRequest)
            }
        }
        
        nameLabel.text = account?.accountName
        if let smallImageURL = account?.profileImageUrl {
            let urlRequest = Session.request(url: smallImageURL)
            profileImageView.af_setImage(withURLRequest: urlRequest)
        }
        

    }
    
    func updateLike() {
        guard let feed = feed else { return }
        let imageName = feed.likedAt == nil ? "like_unselected" : "like_selected"
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.commentImageView_TouchUpInside))
        commentImageView.addGestureRecognizer(tapGesture)
        commentImageView.isUserInteractionEnabled = true
        
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.likeImageView_TouchUpInside))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        
        let tapGestureForNameLabel = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        nameLabel.addGestureRecognizer(tapGestureForNameLabel)
        nameLabel.isUserInteractionEnabled = true
    }
    
    
    @objc func nameLabel_TouchUpInside() {
        if let id = account?.id {
            delegate?.goToProfileUserVC(accountId: id)
        }
    }
    
    @objc func likeImageView_TouchUpInside() {
        guard let feed = feed else { return }
        if let _ = feed.likedAt {
            CommentLikesAPI.unlike(id: feed.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                guard let viewController = weakSelf.parentViewController else { return }
                if let error = error {
                    viewController.show(error)
                } else {
                    feed.likeCount = feed.likeCount - 1
                    feed.likedAt = nil
                    weakSelf.updateLike()
                }
            }
        } else {
            CommentLikesAPI.like(id: feed.id) { [weak self] (error) in
                guard let weakSelf = self else { return }
                guard let viewController = weakSelf.parentViewController else { return }
                if let error = error {
                    viewController.show(error)
                } else {
                    feed.likeCount = feed.likeCount + 1
                    feed.likedAt = 0
                    weakSelf.updateLike()
                }
            }
        }
        
    }
    
    @objc func commentImageView_TouchUpInside() {
        if let id = feed?.id {
            delegate?.goToCommentVC(feedId: id)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholder_profile")
        postImageView.image = UIImage(named: "placeholder_photo")
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        self.volumeView.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

