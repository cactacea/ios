//
//  FeedsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/08.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea

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
        performSegue(withIdentifier: "profile", sender: account)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comment" {
            let vc = segue.destination as! CommentsViewController
            let feed = sender as! Feed
            vc.feed = feed
        } else if segue.identifier == "profile" {
            let vc = segue.destination as! ProfileViewController
            let account = sender as! Account
            vc.account = account
        }
    }

}
