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
            updateView()
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
    
    func updateView() {
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
        if let id = account?._id {
            delegate?.goToProfileUserVC(accountId: id)
        }
    }
    
    @objc func likeImageView_TouchUpInside() {
//        Api.Post.incrementLikes(postId: post!.id!, onSucess: { (post) in
//            self.updateLike(post: post)
//            self.post?.likes = post.likes
//            self.post?.isLiked = post.isLiked
//            self.post?.likeCount = post.likeCount
//        }) { (errorMessage) in
//            ProgressHUD.showError(errorMessage)
//        }
    }
    
    @objc func commentImageView_TouchUpInside() {
        if let id = feed?._id {
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



//        if let ratio = ratio {
//            heightConstraintPhoto.constant = UIScreen.main.bounds.width / ratio
//            layoutIfNeeded()
//        }
//        if let photoUrlString = post?.photoUrl {
//            let photoUrl = URL(string: photoUrlString)
//            postImageView.sd_setImage(with: photoUrl)
//        }
//        if let videoUrlString = post?.videoUrl, let videoUrl = URL(string: videoUrlString) {
//            self.volumeView.isHidden = false
//            player = AVPlayer(url: videoUrl)
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer?.frame = postImageView.frame
//            playerLayer?.frame.size.width = UIScreen.main.bounds.width
//            self.contentView.layer.addSublayer(playerLayer!)
//            self.volumeView.layer.zPosition = 1
//            player?.play()
//            player?.isMuted = isMuted
//        }
