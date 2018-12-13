//
//  FeedsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/08.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import YPImagePicker

class FeedsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var posts = [Feed]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let _ = Session.authentication {
            loadFeeds()
        }
    }
    
    func loadFeeds() {
        FeedsAPI.findFeeds(since: nil, offset: nil, feedPrivacyType: nil, count: nil) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
                weakSelf.posts = result
                weakSelf.tableView.reloadData()
            }
        }
    }

}

extension FeedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
        cell.feed = post
        cell.delegate = self
        return cell
    }
}

extension FeedsViewController: FeedCellDelegate {

    func tappedFeed(feed: Feed) {
        performSegue(withIdentifier: "comment", sender: feed)
    }

    func tappedProfile(account: Account) {
        performSegue(withIdentifier: "comment", sender: account)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comment" {
            let vc = segue.destination as! CommentsViewController
            let feed = sender as! Feed
            vc.feed = feed
        }
        if segue.identifier == "profile" {
            let vc = segue.destination as! ProfileViewController
            let account = sender as! Account
            vc.user = account
        }
    }

}

extension FeedsViewController {
    
    @IBAction func tappedShare(_ sender: Any) {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
            } else if let photo = items.singlePhoto {
                let vc = SharePhotoController.instantinate()
                vc.selectedImage = photo.modifiedImage ?? photo.image
                picker.pushViewController(vc, animated: true)
            } else if let video = items.singleVideo {
                video.fetchData(completion: { (data) in
                    let vc = SharePhotoController.instantinate()
                    vc.selectedImage = video.thumbnail
                    vc.selectedVideo = data
                    picker.pushViewController(vc, animated: true)
                })
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
        present(picker, animated: true, completion: nil)
    }
}
