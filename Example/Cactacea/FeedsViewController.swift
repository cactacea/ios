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

        FeedsAPI.findFeeds(since: nil, offset: nil, feedPrivacyType: nil, count: nil) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.show(error)
            } else if let result = result {
                weakSelf.posts.append(contentsOf: result)
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
    func goToCommentVC(feedId: Int64) {
//        performSegue(withIdentifier: "CommentSegue", sender: postId)
    }
    func goToProfileUserVC(accountId: Int64) {
//        performSegue(withIdentifier: "Home_ProfileSegue", sender: userId)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CommentSegue" {
//            let commentVC = segue.destination as! CommentViewController
//            let postId = sender  as! String
//            commentVC.postId = postId
//        }
//
//        if segue.identifier == "Home_ProfileSegue" {
//            let profileVC = segue.destination as! ProfileUserViewController
//            let userId = sender  as! String
//            profileVC.userId = userId
//        }
//    }

}
