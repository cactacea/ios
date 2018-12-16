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
    
    var posts: [Feed] = []
    var delegate: ProfileHeaderReusableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchUser()
        fetchMyPosts()

    }
    
    func fetchUser() {

        if let authentication = Session.authentication {
            self.navigationItem.title = authentication.account.accountName
            SessionAPI.find { [weak self] (account, _) in
                guard let weakSelf = self else { return }
                guard let account = account else { return }
                authentication.account = account
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    func fetchMyPosts() {
        SessionAPI.findFeeds() { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
                weakSelf.posts = result // .append(contentsOf: result)
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}


extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoCell", for: indexPath) as! ProfilePhotoCell
        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeaderReusableView", for: indexPath) as! ProfileHeaderReusableView
        if let account = Session.authentication?.account {
            headerViewCell.user = account
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






//        if user.id == Session.authentication?.account.id {
//        } else {
//            AccountsAPI.findFeeds(id: user.id) { [weak self] (result, error) in
//                guard let weakSelf = self else { return }
//                if let error = error {
//                    Session.showError(error)
//                } else if let result = result {
//                    weakSelf.posts = result // .append(contentsOf: result)
//                    weakSelf.collectionView.reloadData()
//                }
//            }
//        }
//        if segue.identifier == "ProfileUser_DetailSegue" {
//            let detailVC = segue.destination as! DetailViewController
//            let postId = sender  as! String
//            detailVC.postId = postId
//        }
