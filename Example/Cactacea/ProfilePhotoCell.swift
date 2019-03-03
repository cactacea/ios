//
//  ProfilePhotoCell.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/15/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit
import Cactacea

protocol PhotoCollectionViewCellDelegate {
    func tappedPhoto(postId: Int64)
}

class ProfilePhotoCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    var delegate: PhotoCollectionViewCellDelegate?
    
    var post: Feed? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let url = post?.mediums?.first?.thumbnailUrl {
            let urlRequest = Session.request(url: url)
            photo.af_setImage(withURLRequest: urlRequest, imageTransition: .crossDissolve(0.2))
        }
        
        let tapGestureForPhoto = UITapGestureRecognizer(target: self, action: #selector(self.photo_TouchUpInside))
        photo.addGestureRecognizer(tapGestureForPhoto)
        photo.isUserInteractionEnabled = true

    }
    
    @objc func photo_TouchUpInside() {
        if let id = post?.id {
            delegate?.tappedPhoto(postId: id)
        }
    }
}
