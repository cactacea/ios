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

    var account: Account? = nil
    var posts: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUser()
        fetchPosts()
        
    }
    
    func fetchUser() {
        if let account = self.account {
            self.navigationItem.title = account.accountName
            AccountsAPI.findDetail(id: account.id) { [weak self] (result, _) in
                guard let weakSelf = self else { return }
                guard let account = result else { return }
                weakSelf.account = account
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    func fetchPosts() {
        if let account = self.account {
            AccountsAPI.findFeeds(id: account.id) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let error = error {
                    Session.showError(error)
                } else if let result = result {
                    weakSelf.posts = result // .append(contentsOf: result)
                    weakSelf.collectionView.reloadData()
                }
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
        if let account = self.account {
            headerViewCell.account = account
        }
        return headerViewCell
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
    func tappedPhoto(postId: Int64) {
        performSegue(withIdentifier: "ProfileUser_DetailSegue", sender: postId)
    }
}
