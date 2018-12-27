//
//  Medium+Extension.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/25.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import MessageKit
import Cactacea

extension Medium: MediaItem {
    
    /// The url where the media is located.
    public var url: URL? {
        return URL(string: self.uri)
    }
    
    /// The image.
    public var image: UIImage? {
        return nil
    }
    
    /// A placeholder image for when the image is obtained asychronously.
    public var placeholderImage: UIImage {
        return UIImage()
    }
    
    /// The size of the media item.
    public var size: CGSize {
        return CGSize(width: Double(self.width), height: Double(self.height))
    }
    
}


