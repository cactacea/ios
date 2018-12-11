//
//  ProfileViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/09.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea
import RxSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: Account!

    var posts: [Feed] = []
    var userId = ""
    var delegate: ProfileHeaderReusableViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {
            user = Session.authentication?.account
        }

        fetchUser()
        fetchMyPosts()
    }
    
    func fetchUser() {
        self.navigationItem.title = user.accountName
        self.collectionView.reloadData()

//        Api.User.observeUser(withId: userId) { (user) in
//            self.isFollowing(userId: user.id!, completed: { (value) in
//                user.isFollowing = value
//                self.user = user
//                self.navigationItem.title = user.username
//                self.collectionView.reloadData()
//            })
//        }
    }
    
//    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
//        Api.Follow.isFollowing(userId: userId, completed: completed)
//    }
    
    func fetchMyPosts() {
        if user.id == Session.authentication?.account.id {
            SessionAPI.findFeeds() { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let result = result {
                    weakSelf.posts.append(contentsOf: result)
                    weakSelf.collectionView.reloadData()
                }
            }
        } else {
            FeedsAPI.findAccountFeeds(id: user.id) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let result = result {
                    weakSelf.posts.append(contentsOf: result)
                    weakSelf.collectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "ProfileUser_DetailSegue" {
//            let detailVC = segue.destination as! DetailViewController
//            let postId = sender  as! String
//            detailVC.postId = postId
//        }
    }
    
}


extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeaderReusableView", for: indexPath) as! ProfileHeaderReusableView
        if let user = self.user {
            headerViewCell.user = user
            headerViewCell.delegate = self.delegate
            headerViewCell.delegate2 = self
        }
        return headerViewCell
    }
}

extension ProfileViewController: ProfileHeaderReusableViewDelegateSwitchSettingVC {
    func goToSettingVC() {
        performSegue(withIdentifier: "setting", sender: nil)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 1, height: collectionView.frame.size.width / 3 - 1)
    }
}

extension ProfileViewController: PhotoCollectionViewCellDelegate {
    func goToDetailVC(postId: Int64) {
        performSegue(withIdentifier: "ProfileUser_DetailSegue", sender: postId)
    }
}
