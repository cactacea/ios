//
//  FriendsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import RxSwift
import RxCocoa
import Cactacea
import AlamofireImage

class FriendsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var items = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let _ = Session.authentication {
            loadAccounts()
        }
    }
    
    func loadAccounts() {
        SessionAPI.findFriends(since: nil, offset: nil, count: nil, sortType: nil) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
                weakSelf.items =  result
                weakSelf.tableView.reloadData()
            }
        }
    }
    
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        if let cell = cell as? FriendCell {
            let account = items[indexPath.row]
            cell.account = account
        }
        return cell
    }
    
}

